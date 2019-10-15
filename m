Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95723D6DD5
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2019 05:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfJODdH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Oct 2019 23:33:07 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44182 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbfJODdH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Oct 2019 23:33:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id q21so11512510pfn.11;
        Mon, 14 Oct 2019 20:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v17IeGLW/dg7MHzgbQg0hm5lGoCuR79TfbJB8jiaQoQ=;
        b=EiQqKdgEzfPZqLhcjSWP0k+WMaU2Qz9lOsb78pyj/d64rU3mM1nbKa735G9OUw+Vj0
         LgtIaC9AWHVdAthrXbZ+mAIfHQN/vsSRFgASOXEXQJxYiHmv4ljE+PNOSVWm9pg9bE+e
         NZ09ULUl/LdT2W/VGmw4OD0s2MDiQemSlVYoHLfb2JJ3YhC4ceWOD/4o2Z44J3/TIGVi
         5INMBmGWJTbNuu8Y1dO12NcamEUfAomEHDo4VbktjmerSQzJSXL3pJWJUWus5XDwHqd0
         RtZSvZO9zkA3GCJJooW2ST9g56ogf7m7tB0ZSpxi/3cc1Ud6l2AD/84xg/g8QbChTXWb
         qZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v17IeGLW/dg7MHzgbQg0hm5lGoCuR79TfbJB8jiaQoQ=;
        b=Zn3CxsOjkm27XWiZ71TNUY1Hzb1mf8dgs/0FrkSZSAuVOa1FUDkXfCn26/o5XH3g5a
         TezRxiBKS/EBu4s+pGpLVqcsuO4NDrXQQ7OSk3oDyAuFt/qs3r4Na1A0xmlw6cMASO9T
         vE3zfnCcYmSlBzojbvL82UJS8Ng9azXlGlmJK6m9FsL1qO60YI8mUY48ijLXTSrnWIYi
         ky+h6r+n1ORyzuNxN+ot6/DIhW6J6OKrhLZp6fr4yInh+01Oz9J5o+E22DtMsbyH0MCL
         s/QOfoV1GZiFl/Ijgqjvx7iyRw7nSO4uvfNzvihTsoqMD08q09P1NHhsiASPy+HbmIzI
         1nGg==
X-Gm-Message-State: APjAAAUqotxLU8n3a/bgTRHKOBdglEg4LdskuswvZkL2T82a+yqq7yoz
        T046Bg5aS1lN53kWTqc4P8RTzlUS
X-Google-Smtp-Source: APXvYqwP7PCBXMIwWBobPgR8L5kjJEPhxCh+w/2snnJEx6fG0x+xZ25lJw+FtKIY+PtLjjz0EaiabQ==
X-Received: by 2002:a62:6842:: with SMTP id d63mr35469346pfc.166.1571110385675;
        Mon, 14 Oct 2019 20:33:05 -0700 (PDT)
Received: from localhost.localdomain (S0106d80d17472dbd.wp.shawcable.net. [24.79.253.190])
        by smtp.gmail.com with ESMTPSA id k15sm19973675pfa.65.2019.10.14.20.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 20:33:04 -0700 (PDT)
From:   jassisinghbrar@gmail.com
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     vkoul@kernel.org, masami.hiramatsu@linaro.org,
        orito.takao@socionext.com, Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH v4 0/2] Add support for AHB DMA controller on Milbeaut series
Date:   Mon, 14 Oct 2019 22:33:01 -0500
Message-Id: <20191015033301.14791-1-jassisinghbrar@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Jassi Brar <jaswinder.singh@linaro.org>

The following series adds AHB DMA (HDMAC) controller support on Milbeaut series.
This controller is capable of Mem<->MEM and DEV<->MEM transfer. But only DEV<->MEM
is currently supported.

Changes since v3:
 # Drop unused variables
 # Add controller init instruction

Changes since v2:
 # Spelling mistake fix
 # Bug fix prep_slave - made local copy of sgl

Jassi Brar (2):
  dt-bindings: milbeaut-m10v-hdmac: Add Socionext Milbeaut HDMAC
    bindings
  dmaengine: milbeaut-hdmac: Add HDMAC driver for Milbeaut platforms

 .../bindings/dma/milbeaut-m10v-hdmac.txt      |  32 +
 drivers/dma/Kconfig                           |  10 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/milbeaut-hdmac.c                  | 581 ++++++++++++++++++
 4 files changed, 624 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt
 create mode 100644 drivers/dma/milbeaut-hdmac.c

-- 
2.20.1

