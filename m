Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F33344741
	for <lists+dmaengine@lfdr.de>; Thu, 13 Jun 2019 18:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbfFMQ6Y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Jun 2019 12:58:24 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40626 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729893AbfFMAvc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Jun 2019 20:51:32 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so7332096pla.7;
        Wed, 12 Jun 2019 17:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oSJgfj17bUgTuk9GPBLNPBjjdz6lYPFQFv19Hz3KzW0=;
        b=T0H+KKpK2Tsl4GmvFCodkR9pZgTF1E/sMmaYZs1ijGT6XrTgNZ8STm8ug0teibLo+k
         wdfjEldf2UMhaLrcjrAfsK22rsC6YxcsymWjXA5MIGhgyTTQiFeF7v6bHzL6ZtHvgQmC
         GTrUZs/8DLd9xPTDqengFkLODL5cmuuVNWrqtbKqgIgsIafXoFnJ1tGg08FCAwG+PL6v
         QQvDnZrfuj7GOb1+1QZJPXxwLJHFEpg0Tf8mSHRjgnvUHCjyah6Z3kvQkUq6rBsK/zyZ
         bDd09cCpkQF4QnQTu/pS0/lmlyN3c5Q+RmwAqYeImgeGgcP3Aatw6Ph4To4qJ+GaUKZi
         NeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oSJgfj17bUgTuk9GPBLNPBjjdz6lYPFQFv19Hz3KzW0=;
        b=Cyvp77OUAK5hXbx7/FkJoISgMrHztdBsuC+B7VCtneGB0ROJUonYIQpPzxbUNav9K+
         u0ssp71hGj7XdWjwLKqFSRo3iJjEjCFOejNmvx19/svhQwVT9F3eFCZBLfpcWxUGL01a
         5IFp9w3uiEjU3p/jEoSJctdI5lwkRhBv6IPuUWPfYE0eqIobHce6tlY/5WhkHGsIZiIa
         qyvYW4gLYdwP7wcQqYH83LnGEmcrRHgyA+dbnEMMxIGxpzTyUOt+GxC7mDBZ0aG8PwWe
         PE1uClDxL2bSTwiom37RnNIki9mUSF8G2ddPXosYfUKKMt3xsM6gaQQOm8ELur8KobM3
         oKjQ==
X-Gm-Message-State: APjAAAV3cCO6WGRrwxVTwTMZaUaJWxkLjU9jl/fb6dOsy2pFtfQnRzMt
        mE//0aHtJxX5tukJlUCicb46JIM0
X-Google-Smtp-Source: APXvYqwkqsAfPkLV50CyaPZ3uDtTzILJWDK3zcO7Hf2JXf6UL9/XLvZStg8UJ6EYavfuJfoBMVO3gA==
X-Received: by 2002:a17:902:e312:: with SMTP id cg18mr17539006plb.212.1560387090754;
        Wed, 12 Jun 2019 17:51:30 -0700 (PDT)
Received: from localhost.localdomain ([2604:3d09:b080:d00:7990:5eb3:9633:9569])
        by smtp.gmail.com with ESMTPSA id y68sm690214pfy.164.2019.06.12.17.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 17:51:29 -0700 (PDT)
From:   jassisinghbrar@gmail.com
To:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        orito.takao@socionext.com, masami.hiramatsu@linaro.org,
        kasai.kazuhiro@socionext.com,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH 0/2] Add support for AHB DMA controller on Milbeaut series
Date:   Wed, 12 Jun 2019 19:51:09 -0500
Message-Id: <20190613005109.1867-1-jassisinghbrar@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Jassi Brar <jaswinder.singh@linaro.org>

The following series adds AHB DMA (HDMAC) controller support on Milbeaut series.
This controller is capable of Mem<->MEM and DEV<->MEM transfer. But only DEV<->MEM
is currently supported.

Jassi Brar (2):
  dt-bindings: milbeaut-hdmac: Add Socionext Milbeaut HDMAC bindings
  dmaengine: milbeaut-hdmac: Add HDMAC driver for Milbeaut platforms

 .../bindings/dma/milbeaut-m10v-hdmac.txt           |  54 ++
 drivers/dma/Kconfig                           |  10 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/milbeaut-hdmac.c                  | 572 ++++++++++++++++++
 4 files changed, 637 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt
 create mode 100644 drivers/dma/milbeaut-hdmac.c

-- 
2.17.1

