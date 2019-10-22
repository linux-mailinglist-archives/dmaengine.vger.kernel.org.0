Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98E54E0A59
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2019 19:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387683AbfJVRQ7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Oct 2019 13:16:59 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:39507 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730658AbfJVRQ7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 22 Oct 2019 13:16:59 -0400
Received: by mail-ot1-f46.google.com with SMTP id s22so14862635otr.6;
        Tue, 22 Oct 2019 10:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N+r28++QmE97B3YyUbwqqgILQ6GkScGiNmGk0rbaE4M=;
        b=DIwKEi7queHKniCnlTvSf0yXFfGigi3q7Gdt8CzMnhAcxQwgNlDwh+J4xNyvAHqIcJ
         hrwmE6nbLguADLBhg813NKD9+Ixumefx6kmLhFO1cBSWtAxD/wNsZJ8p6Q5uq/8Vl0oJ
         CM1rRdpWz6rMH+usEi4CYXjtlQL3JoC+Cfesdd1wlh/cHFe6dX+SQnCpD1S7ALDP2gP/
         +iNQAhLEksTzJ7Fs1qphYdiNsBG+EQpWp6fUY5mdlXZFAnhkzsPJNofgQbM0FFR3F/ul
         C/IiV2cbmr4aX/JtVMDdiYoL72w/moDN929ub7DnXWbafUozXsnJ+Wu2Y3isZqPtNHG+
         GV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N+r28++QmE97B3YyUbwqqgILQ6GkScGiNmGk0rbaE4M=;
        b=pev1Zo09sIsUNzOQcjFthhXKGNhroJjgF6QDOrvJ9+aEdlUUHCa1x011Pp4RjWMyGU
         EnpGeyQDtbgmxC9hzYCWiYMbR1hDhakc6GRRHR0y3Q+sN8wIfJFOBsyiiDPtAwlRUche
         cFkxZCGo+Hm8pjthbOXdQy2KVXWd/1tB1GHVKisr32RJ1ml1CMF6WL+gR6V3dn9NCi3F
         1TY+OwmyW51sOYvVltnLoVYspTGtn4LZDnsU4nAlL3GrI7fIRcSShIybh0iMhOOVIx7I
         11GaIaxN3DwZo0c5gLdnRqRKcUvyhPv2OD8FSpm3dJwS31JB/wLO6nJZ9MSm/vAdb/Be
         WgCw==
X-Gm-Message-State: APjAAAXZBOG/cSbTXdaJhPg7tC+dZfsxx5o2ONPqS7Gzbqc/pvwYesGE
        QxOY0v/ZMzUGazabtc57l3Q=
X-Google-Smtp-Source: APXvYqzoONu4gvcCac2l7qmeXHmuK5PoWa0b5XS6T6776F3Bwh8Mph1jJ+2LvkPcF23G7g/L2SkntA==
X-Received: by 2002:a9d:8a5:: with SMTP id 34mr929413otf.197.1571764617978;
        Tue, 22 Oct 2019 10:16:57 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id u130sm4857224oib.56.2019.10.22.10.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 10:16:57 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Peng Ma <peng.ma@nxp.com>, Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH -next] dmaengine: fsl-dpaa2-qdma: Remove unnecessary local variables in DPDMAI_CMD_CREATE macro
Date:   Tue, 22 Oct 2019 10:16:48 -0700
Message-Id: <20191022171648.37732-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Clang warns:

drivers/dma/fsl-dpaa2-qdma/dpdmai.c:148:25: warning: variable 'cfg' is
uninitialized when used within its own initialization [-Wuninitialized]
        DPDMAI_CMD_CREATE(cmd, cfg);
        ~~~~~~~~~~~~~~~~~~~~~~~^~~~
drivers/dma/fsl-dpaa2-qdma/dpdmai.c:42:24: note: expanded from macro
'DPDMAI_CMD_CREATE'
        typeof(_cfg) (cfg) = (_cfg); \
                      ~~~     ^~~~
1 warning generated.

Looking at the preprocessed source, we can see that this is true.

int dpdmai_create(struct fsl_mc_io *mc_io, u32 cmd_flags,
                  const struct dpdmai_cfg *cfg, u16 *token)
{
        struct fsl_mc_command cmd = { 0 };
        int err;

        cmd.header = mc_encode_cmd_header((((0x90E) << 4) | 0), cmd_flags, 0);
        do {
                typeof(cmd)(cmd) = (cmd);
                typeof(cfg)(cfg) = (cfg);
                ((cmd).params[0] |= mc_enc((8), (8), (cfg)->priorities[0]));
                ((cmd).params[0] |= mc_enc((16), (8), (cfg)->priorities[1]));
        } while (0);

I cannot see a good reason to create another version of cfg when the
parameter one will work perfectly fine and cmd can just be used as is.
Remove them to fix this warning.

Fixes: f2835adf8afb ("dmaengine: fsl-dpaa2-qdma: Add the DPDMAI(Data Path DMA Interface) support")
Link: https://github.com/ClangBuiltLinux/linux/issues/746
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/dma/fsl-dpaa2-qdma/dpdmai.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/fsl-dpaa2-qdma/dpdmai.c b/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
index fbc2b2f39bec..f26c0b71688a 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
+++ b/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
@@ -36,10 +36,8 @@ struct dpdmai_rsp_get_tx_queue {
 	((_cmd).params[_param] |= mc_enc((_offset), (_width), _arg))
 
 /* cmd, param, offset, width, type, arg_name */
-#define DPDMAI_CMD_CREATE(_cmd, _cfg) \
+#define DPDMAI_CMD_CREATE(cmd, cfg) \
 do { \
-	typeof(_cmd) (cmd) = (_cmd); \
-	typeof(_cfg) (cfg) = (_cfg); \
 	MC_CMD_OP(cmd, 0, 8,  8,  u8,  (cfg)->priorities[0]);\
 	MC_CMD_OP(cmd, 0, 16, 8,  u8,  (cfg)->priorities[1]);\
 } while (0)
-- 
2.23.0

