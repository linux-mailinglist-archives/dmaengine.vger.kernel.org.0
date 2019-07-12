Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 491FE669BE
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jul 2019 11:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfGLJOK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 12 Jul 2019 05:14:10 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:40649 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfGLJOK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 12 Jul 2019 05:14:10 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N1fei-1iRkwp00C0-0123fC; Fri, 12 Jul 2019 11:13:59 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] dma: ste_dma40: fix unneeded variable warning
Date:   Fri, 12 Jul 2019 11:13:30 +0200
Message-Id: <20190712091357.744515-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IqYlz58Jar5GCfS+BZKg5bdqodHpJJt/MRJG83qdyqbt2wfk7ay
 jgv77Bskqmv+zThYp5kQxBEEFUeJK/7TEWSZWua867UbUso4FFhHQKnxPAM/k8dUhftd1aX
 y7qCx5kTs23ZNbzvo1LLw0T8py9EL/oY97aciP7U+nRyTwDquP+Q3p4UaA05YRQuw1y8Kge
 hBQ0KI5XLuPXrw1icvKAQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6sMZM3JYPV8=:jyJYAUc8zscanrU6pozE1G
 AX+FwJn88+Pr8mfWbhlSKByrpoMhzgLZCQYLOWr0kfZzOWog3drPLTiCLB1w80P7ooJSYjYs4
 Q/r+AzrbR6rxiU165D24jzF8eRXYFFa40MctPdcGfVURNTGf1UMWxg5z5AXM4KfegjpbJTY5+
 OPIF6md7cG9OA/ysWXOFLV1PQsndISFclli8Sl967GgvqSp9Znh+94EUaNHeWvEXLKEN0kygR
 CAgixXrKg/apAFlYh7wViBwKEy1Laxfds4HLQH8R52roaRnOqTUV51JUubf26QH78X/NsrtLB
 XNjW1HlYcf41tdHVnDj3QZDycjtEbdVA7qnfVDzi5WQATtIg32WC8WNSCobXgKXKdZrSugMF1
 zzozNu/5LLK83os0EscPV+OYd29crmsV7myk/5kpZ79nONHb5eakWYLhGbmTXkJg2eFfdr9nu
 KRgmTtmChv5BscbncoZF/SZq11klmYDmzaxmNhumLqO03tMj3PVPQlfcbTbh5EVb4+srb24rl
 BKWrKgkoB868mZGy1L7Yc98QnjbkjxQx0GEQjeH+208gc/qogGi/yqNTex07RNhSu1akZL+r2
 0kjgrM0lkGEFH7qj6uo500ZqYWnmX/LDbgSvOPOv6ghorjrW2HgdIzvFjDVFanpRB/993IYe1
 LJZcifHQGymfvYOAKR0IUYyeuoqXMqd5rWrB9EbHJrBLR6Dkf39jFwIVPxynKNbnOnSnpl5z1
 rJG1dNpLPukoJm1tg3QKCmoTAKqZ0a2X5H1/PA==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

clang-9 points out that there are two variables that depending on the
configuration may only be used in an ARRAY_SIZE() expression but not
referenced:

drivers/dma/ste_dma40.c:145:12: error: variable 'd40_backup_regs' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
static u32 d40_backup_regs[] = {
           ^
drivers/dma/ste_dma40.c:214:12: error: variable 'd40_backup_regs_chan' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
static u32 d40_backup_regs_chan[] = {

Mark these __maybe_unused to shut up the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/ste_dma40.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 89d710899010..de8bfd9a76e9 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -142,7 +142,7 @@ enum d40_events {
  * when the DMA hw is powered off.
  * TODO: Add save/restore of D40_DREG_GCC on dma40 v3 or later, if that works.
  */
-static u32 d40_backup_regs[] = {
+static __maybe_unused u32 d40_backup_regs[] = {
 	D40_DREG_LCPA,
 	D40_DREG_LCLA,
 	D40_DREG_PRMSE,
@@ -211,7 +211,7 @@ static u32 d40_backup_regs_v4b[] = {
 
 #define BACKUP_REGS_SZ_V4B ARRAY_SIZE(d40_backup_regs_v4b)
 
-static u32 d40_backup_regs_chan[] = {
+static __maybe_unused u32 d40_backup_regs_chan[] = {
 	D40_CHAN_REG_SSCFG,
 	D40_CHAN_REG_SSELT,
 	D40_CHAN_REG_SSPTR,
-- 
2.20.0

