Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED1B508752
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 13:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378226AbiDTLuj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 07:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235688AbiDTLui (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 07:50:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80E541FB1
        for <dmaengine@vger.kernel.org>; Wed, 20 Apr 2022 04:47:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 890D7B81D0B
        for <dmaengine@vger.kernel.org>; Wed, 20 Apr 2022 11:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE75C385A4;
        Wed, 20 Apr 2022 11:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650455270;
        bh=Eno66hbZZ/2CF2UG0fatqoS3dJhcxzvB5LC79MAEJEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r/zA/i+cTmAqoF6RztsAL+fnLkmW7M0MtBhV5L6v57KfEw7l6qHRNMmC1pRgwJcIN
         R71V/vnem/CjqEdFwnUqrKIXIqx4tgmMl5VcLyDI16FdV+xKPo7YcJlIiU4ZfQ+8Ab
         HkM6VfKOC1eDVXDqOf20ZaFy00wtWdyl3Te1F4iPuvi4/SyMSd6S4hQQhc7/DEB8rS
         t1nfajSYs5IZX4bDcwkjxOGUO1O/CHv75tjKS7Ll4ZS/9zZMx8jp0e+7rSUtisMcO4
         3Ywd2PAD1OZRzYPvQ9Yz23MPaBR5pelSadVu2rYfkBzEzYyMdPCPFrRsKx9eEShFup
         PRCQrUW+85+sg==
Date:   Wed, 20 Apr 2022 17:17:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: skip clearing device context when
 device is read-only
Message-ID: <Yl/y4iQpwX04/5fW@matsya>
References: <164971479479.2200566.13980022473526292759.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164971479479.2200566.13980022473526292759.stgit@djiang5-desk3.ch.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-04-22, 15:06, Dave Jiang wrote:
> If the device shows up as read-only configuration, skip the clearing of the
> state as the context must be preserved for device re-enable after being
> disabled.

Applied, thanks

-- 
~Vinod
