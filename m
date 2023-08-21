Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58E8782936
	for <lists+dmaengine@lfdr.de>; Mon, 21 Aug 2023 14:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbjHUMfi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Aug 2023 08:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjHUMfh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Aug 2023 08:35:37 -0400
X-Greylist: delayed 464 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Aug 2023 05:35:36 PDT
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05E8991;
        Mon, 21 Aug 2023 05:35:35 -0700 (PDT)
Received: from 8bytes.org (pd9fe95be.dip0.t-ipconnect.de [217.254.149.190])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 14D6D28194F;
        Mon, 21 Aug 2023 14:27:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1692620870;
        bh=FixGPDbY1JGUzoXJGnGCpBH8LX7vfPyc85NTwmVIvZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1GNfM2qXUHu69LlGLcBH8KY7o7o7XmY+SCrGkW/UUIs2KGTpDHXZZbMpPGz6QSYZs
         UPnFUxDcsVEY3pjS1DruthDw9f83ySojUQCSB+rWg+GUD0/AhHwU/y7CvGp4ChZNfv
         PF0U1t4Yrw0S3cKVt3Z1VBJMi6C4Yubn+JBgQ0h8akaCgHt2/SoukE6zqp52PyQtal
         mSBFlaAtIaUSfX6biqD/5UJPh1qGAUoCalqefQ1b2bqiPcVjHwugqG0e+YrG5Eef+K
         UDBnBPokoAbTS28F+RA/gZgu4I/tGuWG+hC4PlSSGwOqv9iwEYEE1WLsVZflD78r+Z
         CJt+ubMPFXzmw==
Date:   Mon, 21 Aug 2023 14:27:47 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Andy Gross <agross@kernel.org>,
        David Airlie <airlied@gmail.com>, alsa-devel@alsa-project.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        dri-devel@lists.freedesktop.org, Emma Anholt <emma@anholt.net>,
        etnaviv@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Frank Rowand <frowand.list@gmail.com>, iommu@lists.linux.dev,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kalle Valo <kvalo@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Sean Paul <sean@poorly.run>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, Vinod Koul <vkoul@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Will Deacon <will@kernel.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH] iommu: Remove the device_lock_assert() from
 __iommu_probe_device()
Message-ID: <ZONYQyMSG17YMc_b@8bytes.org>
References: <0-v1-98d20e768c66+7-of_dma_lock_jgg@nvidia.com>
 <78114fd6-9b83-92ba-418f-6cc7bda9df9b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78114fd6-9b83-92ba-418f-6cc7bda9df9b@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Aug 21, 2023 at 12:06:40PM +0100, Robin Murphy wrote:
> The solution is to drop those locking patches entirely and rethink the whole
> thing.

Agreed, that was exactly what I thought when looking at this patch.

I dropped the original 10 patches and the 4 fixes on-top from the IOMMU
tree. This needs more investigation and adaption of the actual API users
before it can be reconsidered.

Regards,

	Joerg

