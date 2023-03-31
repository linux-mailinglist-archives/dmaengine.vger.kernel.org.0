Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC136D1944
	for <lists+dmaengine@lfdr.de>; Fri, 31 Mar 2023 10:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjCaIET (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Mar 2023 04:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjCaIER (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Mar 2023 04:04:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91D210AA8
        for <dmaengine@vger.kernel.org>; Fri, 31 Mar 2023 01:04:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7946B82C92
        for <dmaengine@vger.kernel.org>; Fri, 31 Mar 2023 08:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FA6C433EF;
        Fri, 31 Mar 2023 08:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680249843;
        bh=QHxia6C/ZeFAsCciounwn5A31/hpmDqOqHFr33qavbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BS+0FEUXbwIAU6qhQFkeyBFDkaZ1zuqH4ex9DBjsWkyHWdba+AnBrzhCNbJgm80Pj
         uDPH7at4tlYgD1NZLCfMm8gazk+hh2Piuwa8MsoUMIjZZ6F9FRNKL+i0ljccS2mJ1c
         DNMJzrZECM0dNwvC3bd3Qn7W+GceLFNKGuh1JsVFRVKggkf+eRiTiNRtqJXLON3Q1z
         7ui3UM1RaVjhdaT0GtYs0T9/72NnD+mDdBAToAOw3ow/q3E8CxkEkKTHCKE4S7A4Qz
         BUSbDlVmj9MwDpRTy+wzqcJkr8IN3p0cudydT6VC6VYrx0FfJKirkVdhfAoioP6Hth
         RArTzdHaAZ35Q==
Date:   Fri, 31 Mar 2023 13:33:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Salter <msalter@redhat.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: tegra: explicitly select DMA_VIRTUAL_CHANNELS
Message-ID: <ZCaT7yGKu3r0FHI9@matsya>
References: <20230329172129.88403-1-msalter@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329172129.88403-1-msalter@redhat.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-03-23, 13:21, Mark Salter wrote:
> Enabling TEGRA186_GPC_DMA will cause this build failure unless some other
> DMA driver which uses DMA_VIRTUAL_CHANNELS is enabled:

Applied, thanks

-- 
~Vinod
