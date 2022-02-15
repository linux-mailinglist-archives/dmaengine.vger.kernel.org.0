Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF924B6B48
	for <lists+dmaengine@lfdr.de>; Tue, 15 Feb 2022 12:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237195AbiBOLiO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Feb 2022 06:38:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236631AbiBOLiN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Feb 2022 06:38:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6BF2409B
        for <dmaengine@vger.kernel.org>; Tue, 15 Feb 2022 03:38:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D9F4B81860
        for <dmaengine@vger.kernel.org>; Tue, 15 Feb 2022 11:38:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E512FC340EB;
        Tue, 15 Feb 2022 11:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644925081;
        bh=y6m26xnifIGRSi/EA+sIoo40HqraY8nQcxTl4JaBEok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NB8Kdue31GlBS82TLbSpVFKBtXrjaAia5YwKHoHmuHc5qaMEzB7zYgLpQ8O5dny6q
         Mrtq7qtEOS12g9qdqU8a+UjQoh0/izy45VYJLelqsNLEalwok7M/vAiHWofSWjaCIc
         6T2R07Lt02+NFeI5+ClH+6zHIiej9Oty2CWAhiFWCRc7aQhEKJzl26gfvEkUiGBgAM
         sEjnTi5C1EI9Xud0XyzzEQmdlvtUdNocc8cNf4+cVsv3dBSI35+lcia0bVfW1vo9C5
         rYKX9CzYrMYlRMFxI68LJm8xjpxA3YmfGnhF8TYniaMWZnVibZgHuMZsTLSyquABrB
         MdwzTTyRe4I5Q==
Date:   Tue, 15 Feb 2022 17:07:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Binuraj Ravindran <binuraj.ravindran@intel.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: restore traffic class defaults after wq
 reset
Message-ID: <YguQlrOA1zM9D3+F@matsya>
References: <164304123369.824298.6952463420266592087.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164304123369.824298.6952463420266592087.stgit@djiang5-desk3.ch.intel.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-01-22, 09:20, Dave Jiang wrote:
> When clearing the group configurations, the driver fails to restore the
> default setting for DSA 1.x based devices. Add defaults in
> idxd_groups_clear_state() for traffic class configuration.

Applied, thanks

-- 
~Vinod
