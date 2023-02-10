Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B863869184C
	for <lists+dmaengine@lfdr.de>; Fri, 10 Feb 2023 07:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjBJGGg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Feb 2023 01:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjBJGGg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Feb 2023 01:06:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C18D74317;
        Thu,  9 Feb 2023 22:06:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A35CB82315;
        Fri, 10 Feb 2023 06:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A81DC433EF;
        Fri, 10 Feb 2023 06:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676009190;
        bh=RYF5hXhDNR43g/SzpPk4uVyCigKI2GB6gUEEBCRVdFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wo3r8MXeVBecOatyA+Dsq0MliLB2Xqsd0xxyDI8qnfWw1lyGVNkl2zSGUiR/FcFJ0
         qA56pv2OTzf/qdUHYQW+ge9W0IW5gyYK8Ck0e+poicDZchiC0xY00FS3hfH8RIJ2mj
         N6EEFN65EbNnEx4XccjVsBKyRdWtEataK0JG6Ig5wkR9/SrR0wOYa4BsA8uNwysuza
         BS5uMb9Dk3Vu5vgHY7TN3nSQ56SYcuxZrAlCbMbiD6KfQGocD9JnjhPQzSqPKmVZpJ
         1haz8ylD46dGPbHw3e+xBXO88e//yM2HUe5Bn/EMFzTykx9vBF5roaLLNh3U5uOaLT
         o6n/3erR+5kVw==
Date:   Fri, 10 Feb 2023 11:36:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org, Ramesh Thomas <ramesh.thomas@intel.com>,
        Nikhil Rao <nikhil.rao@intel.com>
Subject: Re: [PATCH] dmaengine: idxd: Fix default allowed read buffers value
 in group
Message-ID: <Y+Xe4RTN72DTmJRL@matsya>
References: <20230127192855.966929-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127192855.966929-1-fenghua.yu@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-01-23, 11:28, Fenghua Yu wrote:
> Currently default read buffers that is allowed in a group is 0.
> grpcfg will be configured to max read buffers that IDXD can support if
> the group's allowed read buffers value is 0. But 0 is an invalid
> read buffers value and user may get confused when seeing the invalid
> initial value 0 through sysfs interface.
> 
> To show only valid allowed read buffers value and eliminate confusion,
> directly initialize the allowed read buffers to IDXD's max read buffers.
> User still can change the value through sysfs interface.

Applied, thanks

-- 
~Vinod
