Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACB5566F71
	for <lists+dmaengine@lfdr.de>; Tue,  5 Jul 2022 15:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiGENjz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Jul 2022 09:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiGENjn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 5 Jul 2022 09:39:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E909951D4;
        Tue,  5 Jul 2022 06:00:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A18560F89;
        Tue,  5 Jul 2022 13:00:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B89CC341C8;
        Tue,  5 Jul 2022 13:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657026042;
        bh=9xMvBk8PyIWXazGIvBDDt8PNSTWLDQQ3EZxWzllP13k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KWsFMqIrjKe1lrjKAq2geycNRNBmCSzI3khJuOFpZ1ftCHHbExpc4nKkJHNe9eDCw
         BQkCNlNMJP0wBJBfa15nvlYYQqRtBgbiHAqtGIfGtc2Fr4Ia8eJ0kRH/8dTUUxGrwZ
         DzkWdPa0PVhSN4ZCth/Qlrg8lPY5mdsEYRRrk7/G/+giyi1oveBwX1D8Rw5r0N/i+z
         D7KbBNM39rxD7kSkYmINPPiHxYr6BYHm0JoOPjOCiDH72m/F6kZCHmfTlPC+ON6F4Y
         d3neXXdEx24LnUU6iPNKwtazO4GlsOwZ3aJwU/DC8W9A4wicJLvMvsae4h9ItUIg6Q
         omPAMuby4cQ9g==
Date:   Tue, 5 Jul 2022 18:30:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Jiang <dave.jiang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v3] dmaengine: idxd: Only call idxd_enable_system_pasid()
 if succeeded in enabling SVA feature
Message-ID: <YsQ19ZlHmBNTzGgt@matsya>
References: <20220625221333.214589-1-jsnitsel@redhat.com>
 <20220626051648.14249-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220626051648.14249-1-jsnitsel@redhat.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-06-22, 22:16, Jerry Snitselaar wrote:
> On a Sapphire Rapids system if boot without intel_iommu=on, the IDXD
> driver will crash during probe in iommu_sva_bind_device().

Applied, thanks

-- 
~Vinod
