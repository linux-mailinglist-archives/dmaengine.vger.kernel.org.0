Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970EE6575D5
	for <lists+dmaengine@lfdr.de>; Wed, 28 Dec 2022 12:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiL1LUV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Dec 2022 06:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiL1LUS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Dec 2022 06:20:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F870F026;
        Wed, 28 Dec 2022 03:20:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27E1D6146C;
        Wed, 28 Dec 2022 11:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4145C433D2;
        Wed, 28 Dec 2022 11:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672226416;
        bh=QHdGaDtcz9QDN/B/+EkJspx7oX7eWTD4LNT4HFAoSHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NmbhjorZuheVpDBvd9vi4Y9l5Qkajarf/L6jpRWkFq42Ch3JukJ4Vu0hRedvnGHT0
         T+1MEjvCu/twYu63GYsd3F25OJa6LLmSCiT5eqU7KXqnvd96eV6//a162gPi/dezX7
         A3M1aTZrmw+RotSFkU3p3noR1qitZwxjgb9BgRuADEJr0lpXIZfGZoMBbJzjEtYiaw
         NgNTJCxcMoGh1zvpuY8E/rgq4BWJFDu0txTZDkrndyEmGfbZE8j4jiTj9sEyEMKwVM
         Sh/yV595Wtl3QO7576Fl18tC7ms544Hewdblr+nnJ6DP1R1nw2Ahesr2j36hj4W1WW
         tpv89dQMVwQ8w==
Date:   Wed, 28 Dec 2022 16:50:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Joy Zou <joy.zou@nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, shengjiu.wang@nxp.com, martink@posteo.de,
        dev@lynxeye.de, alexander.stein@ew.tq-group.com, peng.fan@nxp.com,
        david@ixit.cz, aford173@gmail.com, hongxing.zhu@nxp.com,
        linux-imx@nxp.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 0/2] dmaengine: sdma support hdmi audio
Message-ID: <Y6wmbIhD03uPyHEj@matsya>
References: <20221115093823.2879128-1-joy.zou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115093823.2879128-1-joy.zou@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-11-22, 17:38, Joy Zou wrote:
> The patchset supports sdma hdmi audio.
> For the details, please check the patch commit log.

Applied, thanks

-- 
~Vinod
