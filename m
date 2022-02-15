Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402414B629D
	for <lists+dmaengine@lfdr.de>; Tue, 15 Feb 2022 06:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiBOFZR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Feb 2022 00:25:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiBOFZQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Feb 2022 00:25:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6025B189F;
        Mon, 14 Feb 2022 21:25:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77B9361331;
        Tue, 15 Feb 2022 05:25:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA00C340EC;
        Tue, 15 Feb 2022 05:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644902706;
        bh=pgl23O8Hvda11XCJ/q6KOIh799qHwG0ne6iHjk5OIy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t/1G/3FhPHQNE5Ii5LaeD7zvXH+hZqsE4q4mvqbrXRXqY+LkbtsBa6i+sBq3QMtxU
         11V7wYD+0arJp5lRcdnkIK/RFjpHnTOxD16MDqL/EBw+5Lap5z9epMShpV8wVRmHA1
         y2DigVPJBtcKUwy+4qPDQvAwufgA+vWogRA4sImMHkOWAzphWsTo/Ol+SqMI7beLiU
         8pra5icpYzk4hPcxhULU3hMsyLRyXwByDiTowSBZppIypkitGyDfpYOdO7mXayA/VX
         haBKMvmCt5GvZlSx0YbxVI8Auw2hjaSDuacz6pBbBjiFKb1UqOwv8a0+2dkOl2dtT3
         nVHIik1q/eP5w==
Date:   Tue, 15 Feb 2022 10:55:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Added few improvement and fixes.
Message-ID: <Ygs5L6N8DXznCyjV@matsya>
References: <1643814880-3882-1-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643814880-3882-1-git-send-email-Sanju.Mehta@amd.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02-02-22, 09:14, Sanjay R Mehta wrote:
> From: Sanjay R Mehta <sanju.mehta@amd.com>
> 
> This patch series fixes a concurrency issue with DMA transfer and
> descriptor handling with a graceful exit.

Applied, thanks

-- 
~Vinod
