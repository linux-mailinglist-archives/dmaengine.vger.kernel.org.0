Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C95250AFFF
	for <lists+dmaengine@lfdr.de>; Fri, 22 Apr 2022 08:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444129AbiDVGFI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Apr 2022 02:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444113AbiDVGFF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Apr 2022 02:05:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520C24F9FA;
        Thu, 21 Apr 2022 23:02:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2DCE61DC8;
        Fri, 22 Apr 2022 06:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B682EC385A4;
        Fri, 22 Apr 2022 06:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650607331;
        bh=4841fxDo2IBFBAW/st3C9bLw2mUJ8qtFufsuF9mZbWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RQwBI/WC4vM1T5dWLU1/Q20cPmmCuTVI3H7URdIOvuNuybvwmyA4T/99z3W0rO8wi
         XaQ4/ywPvslBHuQcn8QDVOOCxuplNxf6G/1xbuBCwpa/4bjxCbkdtdsusXHSCmgz8h
         lcXhpt46CJviGbDzAeK4jwjhscWjp6Wkkf6hSxjj69dRTr+pJG6StSqVtav6Dk+gmW
         gNWzYNrLCGQVgts9lSkzT6kzQIjn9RxnlELwlt0p0KuIXnQgeXjXfr5nJQtKLVizu0
         jM0k9T/dVMw5bXy9IdfzR/SJX2X5VMGncFtL2VMKfjqnoE0+D5u98nBks232h1vzn6
         cT68y/ovBAJ/g==
Date:   Fri, 22 Apr 2022 11:32:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: Fix the error handling path in
 idxd_cdev_register()
Message-ID: <YmJE3/zDdp/1YiaD@matsya>
References: <1b5033dcc87b5f2a953c413f0306e883e6114542.1650521591.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b5033dcc87b5f2a953c413f0306e883e6114542.1650521591.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-04-22, 08:13, Christophe JAILLET wrote:
> If a call to alloc_chrdev_region() fails, the already allocated resources
> are leaking.
> 
> Add the needed error handling path to fix the leak.

Applied, thanks

-- 
~Vinod
