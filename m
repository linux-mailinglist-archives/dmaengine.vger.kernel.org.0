Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76404691AB3
	for <lists+dmaengine@lfdr.de>; Fri, 10 Feb 2023 10:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjBJJEi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Feb 2023 04:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjBJJEO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Feb 2023 04:04:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B705871660;
        Fri, 10 Feb 2023 01:03:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 558C760ABA;
        Fri, 10 Feb 2023 09:03:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29365C433EF;
        Fri, 10 Feb 2023 09:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676019784;
        bh=SIMnIdB8bAa8D2y9QtxIwGAUnqTH4p2L1mVkPYcmpd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eel5T9mdGda3/FfqtrcKAq7M7MHeglp2qPEXrfE5ccnGoivDyZISsCFHGNKHgVOet
         oX7gPaVoOlBITF7AK1NU2hh1oPO/TXsbL5a1wFNs8b24N3yb1ROwRnLAzB6zy8NDl0
         uCnGylTdZKLW2SsCUGfFMEG/MklyZZZfAWtgFmPvUtRcDGSCnVzNfOxWVIUWU8EZ9z
         ukDEUxs2b9CRWEyjdPEA+xlayr/SqhvhZrergHtcwNXF4tsMcjnXTgB9pKMO1gD8zq
         bpVzdFmjF4Gn44u5ulAjjkrOjhKllDJMQq3HQpqwsgu4xV8UBv8U3b7eRRUlOSxbNt
         LeSBfdMT3X3+Q==
Date:   Fri, 10 Feb 2023 14:32:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     aman.kumar@intel.com
Cc:     dmaengine@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        srikanth.thokala@intel.com, mallikarjunappa.sangannavar@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] dmaengine: idma64: Update bytes_transferred field
Message-ID: <Y+YIQkrlJvGOh1bn@matsya>
References: <20230203121702.15725-1-aman.kumar@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203121702.15725-1-aman.kumar@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-02-23, 17:47, aman.kumar@intel.com wrote:
> From: Aman Kumar <aman.kumar@intel.com>
> 
> Currently when 8250 data transfer is done, bytes_tranferred always returns
> 0 at /sys/devices/pci0000\:\:**.*/dma/dma*chan*/bytes_transferred.
> In many cases it gives false impression that data is not being
> trasferred via DMA.
> 
> So, updating the bytes_transferred field to count the bytes
> whenever there is data transfer using idma64.

Applied, thanks

-- 
~Vinod
