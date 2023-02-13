Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A00693DD6
	for <lists+dmaengine@lfdr.de>; Mon, 13 Feb 2023 06:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjBMFZZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Feb 2023 00:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBMFZY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Feb 2023 00:25:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22311EB5D;
        Sun, 12 Feb 2023 21:25:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 765BD60E00;
        Mon, 13 Feb 2023 05:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED875C433EF;
        Mon, 13 Feb 2023 05:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676265921;
        bh=cFtS3xkef6a7VyPTMfHmHcvFjxTQdrZtBj252qcLTOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E2bgsVEwfTYI71iLSgTbzcGt5voQ7gS1lZ7HPzjJ4iUs/jttcHrV6aRulgDwePMYd
         tXoBmPrhnJxBi77okA0wtGLsYmkmTgW54N4Nqa68TO+LTysndugCzuJK81WIGEql3D
         Fmtu+FscBV4wUaO4NbkdJJ7VDPHf3jw7EUiVORsqMxCj4fsLFUjSr1U61yiRRHMNpA
         amwhXf/16jjdWrAXBfIay9Rzhb5dP/QJ0NSzg0Lt28DHPGEuQZ4NRe5nkFLQ+8AEJw
         o/vh4rHBeql+Zm4zTHXrl5bAyXn5iWIgwXOJqoORQmAYAfUL2KUZx+qAL7xdVpgtV9
         9FxLyauLRi7Eg==
Date:   Mon, 13 Feb 2023 10:55:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Janne Grunau <j@jannau.net>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>,
        =?utf-8?B?77+9ZXI=?= <povik+lin@cutebit.org>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH 15/17] dt-bindings: dma: apple,admac: Add t8112-admac
 compatible
Message-ID: <Y+nJvR4itBN6x+jd@matsya>
References: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
 <20230202-asahi-t8112-dt-v1-15-cb5442d1c229@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202-asahi-t8112-dt-v1-15-cb5442d1c229@jannau.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-02-23, 16:41, Janne Grunau wrote:
> The block found on Apple's M2 SoC is compatible with the existing driver
> so add its per-SoC compatible.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> 
> ---
> This trivial dt-bindings update should be merged through the asahi-soc
> tree to ensure validation of the Apple M2 (t8112) devicetrees in this
> series.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
