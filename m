Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB0B619665
	for <lists+dmaengine@lfdr.de>; Fri,  4 Nov 2022 13:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiKDMla (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Nov 2022 08:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiKDMl3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Nov 2022 08:41:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADA66579;
        Fri,  4 Nov 2022 05:41:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 997A46216F;
        Fri,  4 Nov 2022 12:41:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDF1C433D6;
        Fri,  4 Nov 2022 12:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667565687;
        bh=LnaHhDoo9rCQOdDxxzfKdDbPoZ5D/fnx1KFW8YcmFV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QOJEyjvTPGRCxwpjqjwB47wOvleU8AqzQ1U2FeWSOuVDxTPLTWbRao52Q5bUEwBY7
         mO4QU/vPnSMvvA6EWoPCa0rEcr1ohE1GMFvcHnqa60ewIlYrn5dwEFndJdTy4d+Pfq
         ycbIhFEJESB/6n8p+mC8rB2QdX36/krY7pee5CR34O8j22Aja0XD6uBzhe0usZCIhT
         pvq8LBJ6rrvb7Mu+RiimEgZB5LAy3JD1cJ4oZiVor/j33wQVu8IGo12iRSwhRxjCaa
         eoGKCxwrr7Tsxi6Vaque0+I9FxcSGpJOvmIZ/14TnZPk3HlG8xkiXn5sckoJ3VaJPK
         f6FyIT4mBG9oA==
Date:   Fri, 4 Nov 2022 18:11:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Anastasia Belova <abelova@astralinux.ru>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] vdec_vp9_if: add check for NULL for
 vsi->frm_bufs[vsi->new_fb_idx].buf.fb in vp9_swap_frm_bufs
Message-ID: <Y2UIcjjpxDIDDQQm@matsya>
References: <20221028092516.19070-1-abelova@astralinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028092516.19070-1-abelova@astralinux.ru>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-10-22, 12:25, Anastasia Belova wrote:
> If vsi->frm_bufs[vsi->new_fb_idx].buf.fb == NULL while cleaning
> fb_free_list NULL-pointer is dereferenced.

Clearly you have incorrect maintainer and list, pls fix and send to
relevant ppl

> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
>  drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c b/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c
> index d9880210b2ab..dea056689b48 100644
> --- a/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c
> +++ b/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c
> @@ -512,7 +512,7 @@ static void vp9_swap_frm_bufs(struct vdec_vp9_inst *inst)
>  	 * clean fb_free_list
>  	 */
>  	if (vsi->frm_bufs[vsi->new_fb_idx].ref_cnt == 0) {
> -		if (!vp9_is_sf_ref_fb(
> +		if (vsi->frm_bufs[vsi->new_fb_idx].buf.fb != NULL && !vp9_is_sf_ref_fb(
>  			inst, vsi->frm_bufs[vsi->new_fb_idx].buf.fb)) {
>  			struct vdec_fb *fb;
>  
> -- 
> 2.30.2

-- 
~Vinod
