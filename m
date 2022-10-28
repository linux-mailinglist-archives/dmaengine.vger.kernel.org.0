Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AF5610D6A
	for <lists+dmaengine@lfdr.de>; Fri, 28 Oct 2022 11:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiJ1Jg2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Oct 2022 05:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiJ1JgG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Oct 2022 05:36:06 -0400
X-Greylist: delayed 597 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 28 Oct 2022 02:35:27 PDT
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394B959244;
        Fri, 28 Oct 2022 02:35:26 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 44B421863F30;
        Fri, 28 Oct 2022 12:25:26 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wmW6qRmkIY0a; Fri, 28 Oct 2022 12:25:26 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 04B521863F18;
        Fri, 28 Oct 2022 12:25:26 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id es316AFVOzqz; Fri, 28 Oct 2022 12:25:25 +0300 (MSK)
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.177.20.20])
        by mail.astralinux.ru (Postfix) with ESMTPSA id A95B11863ED2;
        Fri, 28 Oct 2022 12:25:25 +0300 (MSK)
From:   Anastasia Belova <abelova@astralinux.ru>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Anastasia Belova <abelova@astralinux.ru>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] vdec_vp9_if: add check for NULL for vsi->frm_bufs[vsi->new_fb_idx].buf.fb in vp9_swap_frm_bufs
Date:   Fri, 28 Oct 2022 12:25:16 +0300
Message-Id: <20221028092516.19070-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

If vsi->frm_bufs[vsi->new_fb_idx].buf.fb =3D=3D NULL while cleaning
fb_free_list NULL-pointer is dereferenced.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c b/drive=
rs/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c
index d9880210b2ab..dea056689b48 100644
--- a/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c
+++ b/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c
@@ -512,7 +512,7 @@ static void vp9_swap_frm_bufs(struct vdec_vp9_inst *i=
nst)
 	 * clean fb_free_list
 	 */
 	if (vsi->frm_bufs[vsi->new_fb_idx].ref_cnt =3D=3D 0) {
-		if (!vp9_is_sf_ref_fb(
+		if (vsi->frm_bufs[vsi->new_fb_idx].buf.fb !=3D NULL && !vp9_is_sf_ref_=
fb(
 			inst, vsi->frm_bufs[vsi->new_fb_idx].buf.fb)) {
 			struct vdec_fb *fb;
=20
--=20
2.30.2

