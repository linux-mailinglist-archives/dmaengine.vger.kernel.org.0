Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFF85F0FB7
	for <lists+dmaengine@lfdr.de>; Fri, 30 Sep 2022 18:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbiI3QRu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 30 Sep 2022 12:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbiI3QRs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 30 Sep 2022 12:17:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A2411F7DC;
        Fri, 30 Sep 2022 09:17:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E14D2B8295B;
        Fri, 30 Sep 2022 16:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0C1C433D6;
        Fri, 30 Sep 2022 16:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664554664;
        bh=pE7BzumgW1ynDuD7p2V+y/Sd7vHjBG8s1f+eMEx2qVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vCKpcbQAPFKRY/KSYo2fjWQvg8dyJ30hIfRZtnrzvQNQL5wnuhB3uxyBDYOrFQt1D
         qjfiWJdkRro5KEDIg2CqiQpcY36AlxO+1yOT8TCiQ0vgWzlqdePSQIsZ7MKAEeQzig
         oGKnpnolzjQDaiQsvtbIGRaPvctd3a4XDnM2ogeZ1N49Qz6xi7InFnCGOowRl9boSU
         yAgJxqX0s2oWlB45BzgQekega9fQiyXxYLnNPiJRmbLA0uadFGDVf+5OMc3wczHWdm
         hNP2zEtLGc2KBhF6iKfzojXQqS0C9elRjystNA8Dd2cLfU6eBKqgRQcEwH8SRQgV8r
         87OUihxADpPLg==
Date:   Fri, 30 Sep 2022 21:47:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Koba Ko <koba.ko@canonical.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dmaengine: Fix client_count is countered one more
 incorrectly.
Message-ID: <YzcWowD/WA/9oit7@matsya>
References: <20220830093207.951704-1-koba.ko@canonical.com>
 <20220929165710.biw4yry4xuxv7jbh@cantor>
 <YzXRbBvv+2MGE6Eq@matsya>
 <4394cae0b5830533ed5464817da2c52119e30cea.camel@redhat.com>
 <CAJB-X+XYq6JRewKkPu0OSnEhJAsW5qFcs2ym2c+wErxWgoXGDA@mail.gmail.com>
 <20220930055619.ntgr2yobc5euzz6y@cantor>
 <CAJB-X+X2k_TCvocoiFsPr=ehSMOHZkBkOv_P540q=_jmxXgYTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJB-X+X2k_TCvocoiFsPr=ehSMOHZkBkOv_P540q=_jmxXgYTw@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-09-22, 14:25, Koba Ko wrote:
> On Fri, Sep 30, 2022 at 1:56 PM Jerry Snitselaar <jsnitsel@redhat.com> wrote:

> 
> Sorry, I misunderstood. actually, there's a mistake on the [3/3] part.
> I created patches for the mainline kernel before sending them to the upstream.
> Then I found the first has existed on the patchwork, so removed the
> [2/3] part for ccp patch and forgot to modify for this.
> Should I fix this and re-submit v2(also add those review-by)?

Yes please

-- 
~Vinod
