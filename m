Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD805EFA10
	for <lists+dmaengine@lfdr.de>; Thu, 29 Sep 2022 18:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbiI2QSs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Sep 2022 12:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236112AbiI2QSd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Sep 2022 12:18:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7398114B857;
        Thu, 29 Sep 2022 09:18:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28458B824FA;
        Thu, 29 Sep 2022 16:18:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4266FC433D6;
        Thu, 29 Sep 2022 16:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664468308;
        bh=KQ0mSuwHv27mooliEcomTryuth3leZThDBOY5PPamBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vb0g7+pPE4VNJvnbBLRkGHraTdCqn6whQehkaiFm4qROS2v6xR7PNLwFH6+yCtmby
         eP1st0pncL+bgfAj3YZc7t3ZF82m0vfQn45Q6BPf7CKpr4oY4Uen3FDawau1uLzK0F
         TWqMXRdNqGzJDo1iaj40lwfYN8mmSvwX6aPZrVPKvmD8YR8Dh+eG/hsVBSqMalYX/D
         6e4i1b67dEpZd10pEClJQR/l6X48qbcdqNqf3gzsx2ce1zMMfKYvH2tkeACNeBgNyV
         1V1+Db2iroVcTOgPMXzEF2e+ozXUn9UAJSw/xMTf+A0ppcoUU0QCelQfp9W60rB7Ld
         86y+bwl55sfXw==
Date:   Thu, 29 Sep 2022 21:48:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Matt Ranostay <mranostay@ti.com>
Cc:     nm@ti.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND 0/2] dmaengine: ti: k3-psil: add TX threads for
 J721E + J7200 platforms
Message-ID: <YzXFUCIJryeHaVvd@matsya>
References: <20220919205931.8397-1-mranostay@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919205931.8397-1-mranostay@ti.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-09-22, 13:59, Matt Ranostay wrote:
> Add additional PSI-L TX threads for peripherals on both J721E and J7200 platforms.

Applied, thanks

-- 
~Vinod
