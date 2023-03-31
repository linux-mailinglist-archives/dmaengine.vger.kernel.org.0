Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DA06D2078
	for <lists+dmaengine@lfdr.de>; Fri, 31 Mar 2023 14:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjCaMel (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Mar 2023 08:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjCaMej (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Mar 2023 08:34:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE832030D;
        Fri, 31 Mar 2023 05:34:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D043628B1;
        Fri, 31 Mar 2023 12:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48309C433EF;
        Fri, 31 Mar 2023 12:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680266046;
        bh=ecbfN73xdSOCMpPZ4gL9caSduEaqcLq44R9oQrYFivU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BQhjRB+Vvm+yziKGy5vLFR4P4Wei41SUHYPrD1otF4vo6qvZPQx2/tuZiXyeivDdk
         6HLlfRcFHEGBvmLVD/RvkASTVZH+PMB+V2M/PjPjsRSHTM0vNyOsKdNpGNWeBupJug
         P6yPaDZ+8nnpF1cLKhZ8FgglklBtV9YIg6V3UbAgXxrLBP3WN70+sKIINf/Pykzwt2
         suTlKzMVNh7i9X4KLzwSXMU3viuxNmOq6JvmX5aCKfwVmK0aqqDqn9Q1D+VmIa0sgB
         0zVH9o1W4I97Dw5ZCAms7fa6GikaUsmVXdqbA+BL4mGjupcmKXGRD1DSW3aCK035am
         GCUCJQhbKLI7A==
Date:   Fri, 31 Mar 2023 18:04:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jayesh Choudhary <j-choudhary@ti.com>
Cc:     peter.ujfalusi@gmail.com, a-nandan@ti.com, hnagalla@ti.com,
        s-vadapalli@ti.com, vigneshr@ti.com, vaishnav.a@ti.com,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: k3-psil: Add PSI-L thread support for
 J784s4
Message-ID: <ZCbTOonNHnF4D9LV@matsya>
References: <20230308201513.116638-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308201513.116638-1-j-choudhary@ti.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-03-23, 01:45, Jayesh Choudhary wrote:
> From: Apurva Nandan <a-nandan@ti.com>
> 
> Add psil thread IDs for J784s4 and include J784s4 in the set of
> "k3_soc_devices" in k3-psil.c.

Applied, thanks

-- 
~Vinod
