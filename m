Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3C87AE209
	for <lists+dmaengine@lfdr.de>; Tue, 10 Sep 2019 03:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfIJBnx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Sep 2019 21:43:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42620 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfIJBnx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Sep 2019 21:43:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id p3so8904301pgb.9;
        Mon, 09 Sep 2019 18:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tQz7sfG4jMDOKCd5wyddF9djIFGlkDXk4QGu55dK5ME=;
        b=rKZ21QbPiY8/ylm+MXx3uWbXc4HqpCjMVN4HNqCfk9jsVAMtMta9jg5htpLlpD63CE
         gXriVgEkuN7XSrEjSoLsGtZOGbTPMCIPlbGzwVC2jrAiAunEdeldICTe2S2PQ1cDR62T
         zdvVpe86VYQhA5xTppbb8cXchJVxffy0usQbICbwa1cpVaIg6gCLBc7RoYXKD7or6grA
         b8KwF74Rg56SDx/OSQ4mZT/HPSz2+tHqCyZmeOn4wkgfuAB8UedtRnITcQxh+K54iEkB
         yN54/H5IGNGSgHAS5phteOI60EIIn0fGgDQfDR35hoi3O/Lpnids+c19lqzVP2KWKhb8
         jcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tQz7sfG4jMDOKCd5wyddF9djIFGlkDXk4QGu55dK5ME=;
        b=lbGSioqbvQrTG6nj1sh7mx5dZ936RhOPhMpgJB7qLN5XwaRCaS6KRn6BhIum7HZmyG
         43qb3FGMx0GAXu1SHCN+u/duLCFag8faO+w5+RlkgcZa3oFUmnfSytZ/yDVF+IcK4km0
         VEYTDkS0LWVekmNfYfnvCrD7jokeAs9FJHOMHg7fQarYuBwWchkop/fQiqYr8xZJf2SE
         0uF57XRCUwb/SnIT7SV+9a5qd8DimVV2QFfH67KZmKO8hGIhH07m3JLsRM14oOqm+/F5
         WQq+EJPpqZbR9hvWtJNVdoI+4uufN7Ot93AaiPFXVPJ3+ev/ycK/qdB2idmNUwguUik2
         Mtwg==
X-Gm-Message-State: APjAAAUG+diyMWVACpOkR44uWsGSPpxVaPU2oc2w/9lQNDSPGmtb7wef
        LpILof0EVzwoKvrWf76e7AdG4ro4
X-Google-Smtp-Source: APXvYqzbIvRg3VW0bih80gcEtaGBhghTbPvmmYkgVwYuI2chA1RstpXygMDMQ9EqqzMjjorgurUWRA==
X-Received: by 2002:aa7:86c3:: with SMTP id h3mr593344pfo.85.1568079832499;
        Mon, 09 Sep 2019 18:43:52 -0700 (PDT)
Received: from localhost.localdomain (S0106d80d17472dbd.wp.shawcable.net. [24.79.253.190])
        by smtp.gmail.com with ESMTPSA id v12sm14383446pgr.86.2019.09.09.18.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 18:43:51 -0700 (PDT)
From:   jassisinghbrar@gmail.com
To:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     vkoul@kernel.org, robh+dt@kernel.org, masami.hiramatsu@linaro.org,
        orito.takao@socionext.com, Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH v2 0/2] Add support for AXI DMA controller on Milbeaut series
Date:   Mon,  9 Sep 2019 20:43:06 -0500
Message-Id: <20190910014306.5318-1-jassisinghbrar@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Jassi Brar <jaswinder.singh@linaro.org>

The following series adds AXI DMA (XDMAC) controller support on Milbeaut series.
This controller is capable of only Mem<->MEM transfers. Number of channels is
configurable {2,4,8}

Changes Since v1:
  # Spelling mistake fix

Jassi Brar (2):
  dt-bindings: milbeaut-m10v-xdmac: Add Socionext Milbeaut XDMAC
    bindings
  dmaengine: milbeaut-xdmac: Add XDMAC driver for Milbeaut platforms

 .../bindings/dma/milbeaut-m10v-xdmac.txt      |  24 +
 drivers/dma/Kconfig                           |  10 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/milbeaut-xdmac.c                  | 426 ++++++++++++++++++
 4 files changed, 461 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/milbeaut-m10v-xdmac.txt
 create mode 100644 drivers/dma/milbeaut-xdmac.c

-- 
2.17.1

