Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83177528492
	for <lists+dmaengine@lfdr.de>; Mon, 16 May 2022 14:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243470AbiEPMua (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 May 2022 08:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243465AbiEPMuP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 May 2022 08:50:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDAE3A5C1
        for <dmaengine@vger.kernel.org>; Mon, 16 May 2022 05:49:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0AC6B811D3
        for <dmaengine@vger.kernel.org>; Mon, 16 May 2022 12:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E32C385AA;
        Mon, 16 May 2022 12:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652705384;
        bh=wWN57vaEEDPEKmafR6DzGIK1CI+rcXGyfhfnJkcJYw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DvOyBR8zV0UUYzrSoM1lMiXpKx1KuLw+UpMCHaSuTjpT10FFyrrt3SrVa/6mAYjjR
         4OQzSfoVyNv5XHvGfkQROxF9tpdII6+P6cTGn55lMVNX3u5WAkcIBvl/sOvXgPNkfV
         fDy1JQyscrk1a+zRb5WOoOrsGF9P/vHNlv15g5jwGvjvwde8WgjHtXnKOp6lOLXMlN
         b/HNk+LDqvBW6o3ehgUtS6+9eTkxvfrt7FP0DdvtLgFWB9olfbL+AMqpEaaqfd7dxw
         3ILeNyFyaOPSg4CNxgZ60ID4gV2Qc06H58L5IBXTu+0oSd/N99tOIx3YuCw4TlBlME
         g4wKhSq9QW/yw==
Date:   Mon, 16 May 2022 18:19:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Jacob Pan <jacob.jun.pan@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: fix lockdep warning on device driver
 removal
Message-ID: <YoJIZB5H4RjTZR0b@matsya>
References: <165231364426.986304.9294302800482492780.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165231364426.986304.9294302800482492780.stgit@djiang5-desk3.ch.intel.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-05-22, 17:00, Dave Jiang wrote:
> Jacob reported that with lockdep debug turned on, idxd_device_driver
> removal causes kernel splat from lock assert warning for
> idxd_device_wqs_clear_state(). Make sure
> idxd_device_wqs_clear_state() holds the wq lock for each wq when
> cleaning the wq state. Move the call outside of the device spinlock.

Applied, thanks

-- 
~Vinod
