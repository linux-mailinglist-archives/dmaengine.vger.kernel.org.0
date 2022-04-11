Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6D64FBDAF
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 15:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346743AbiDKNtD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 09:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346709AbiDKNs3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 09:48:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714A117A93;
        Mon, 11 Apr 2022 06:46:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96BAE61139;
        Mon, 11 Apr 2022 13:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA48C385A3;
        Mon, 11 Apr 2022 13:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649684766;
        bh=aKWtMXMYxdsO6I90VlJwQ62Km1pU/xrQPigF44yjuqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Za1uvVJ5WJ79A+NuP3YEjveGAd0yezV5F6zXkRPkcSjWTrdHc+iFtJgf6x1P4IRSJ
         /sxdsPkcNFpQey0mOUSyz2nnZWmzqrmXNITNL1UH735ufifR2neJZuSVPd6QkEXviA
         IXbg9bA217iK5cdKr2+S2PJ6nmu4JTEG+ed6BaG3soLD/gVN6ph2zL1umZzvk/+OVJ
         g1EVG5yMa3aP8ytfvhbBt5068DnnTFQOs5RKn/k6pnCWKMmSLzdiZyMcttevC8Jwo/
         yMjd8RPWqcUHuThAPwFlSLqKGPiNIC65ZxOjR/Ln9uvdfl87AkxkJOqfpjQulX6ztu
         Vl/NCeyp59zGA==
Date:   Mon, 11 Apr 2022 19:16:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] dmaengine: Clarify cyclic transfer residue documentation
Message-ID: <YlQxGh9Jhzm4ekb7@matsya>
References: <20220331134114.703782-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331134114.703782-1-paul.kocialkowski@bootlin.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 31-03-22, 15:41, Paul Kocialkowski wrote:
> The current documentation for the residue reported in a cyclic transfer
> case mentions that the reported residue should be relative to the current
> period only. However the definition of DMA_RESIDUE_GRANULARITY_SEGMENT
> specifies that the residue should be updated after each period for
> a cyclic transfer, which is in direct contradiction.
> 
> Moreover the pcm_dmaengine common code uses the residue relative to
> the whole cyclic buffer size, not one period.
> 
> Correct the residue-related documentation to reflect this.

Applied, thanks

-- 
~Vinod
