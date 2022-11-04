Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67A6619A64
	for <lists+dmaengine@lfdr.de>; Fri,  4 Nov 2022 15:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbiKDOnr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Nov 2022 10:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbiKDOnA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Nov 2022 10:43:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271E4DE8;
        Fri,  4 Nov 2022 07:42:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9FA6B82E10;
        Fri,  4 Nov 2022 14:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29E3C433C1;
        Fri,  4 Nov 2022 14:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667572975;
        bh=ijn1vLKlu1+ocFrXvKH3N1EzCWI7TJIBVl7TdNwMX44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eLrEmEnIoTAk/VyTKYL3jlycAVsIkOgtICGLsfe6e9XPvvyWBB8GWnXV0njA7DtBe
         CoHYdo8zPdYVRTOfBJlkTg+aATYo5ih5OhhxKG0toCU9dppQ/z1pPM3tT3RSsiFlme
         kgR0aV6wc9mGohzYBzezA6BwDuSZBzYfTnjNtSuoCBuJPOf6tqiyIscMSc5VewWy+B
         jm9IZ+TP8WxdouDpsX2jXk/OEemMpthBXcGSyKXu7iufLAuZyUqBNREXh761AWmNbQ
         WpqOdWVk20v8j0ejb+gO4ykey/Qb132h6/SXRdppyztCcxzcdbJER7aDuy1/pnu1M/
         3o0sxevCxiRwA==
Date:   Fri, 4 Nov 2022 20:12:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: sh: Remove unused shdma-arm.h
Message-ID: <Y2Uk6+2XjP3MfidF@matsya>
References: <20221028115336.1052782-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028115336.1052782-1-steve@sk2.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-10-22, 13:53, Stephen Kitt wrote:
> shdma-arm.h was introduced with commit 1e69653d40f1 ("DMA: shdma: add
> r8a73a4 DMAC data to the device ID table"), and its sole user was
> removed with commit a19788612f51 ("dmaengine: sh: Remove R-Mobile APE6
> support"). The latter mentions r8a73a4.dtsi but shdma support was
> removed from that with commit cfda82037780 ("ARM: dts: r8a73a4: Remove
> non-functional DMA support"), so it seems this is safe to remove.

Applied, thanks

-- 
~Vinod
