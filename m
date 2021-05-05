Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D414B374AFD
	for <lists+dmaengine@lfdr.de>; Thu,  6 May 2021 00:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhEEWKm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 May 2021 18:10:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229691AbhEEWKl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 5 May 2021 18:10:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62919613D6;
        Wed,  5 May 2021 22:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620252584;
        bh=MrFPJWMFWa2Yv9X0RL/C0HOz8fh7sy6Uvwm9FYcYjag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HsZXp4zUwt0UoBrKcTcj6EsxJQg9uZZYCxa4FRbrCpAmBwzWySsLoqBR4DcWc++kN
         DTH8r+R2tQ9HEFB+csGOwEc2tvq9g7oEx3tvuaWz2a0oH87B2q6ueKrQEMWia8EE4i
         uu1VqX//aBuEXL+uDX4zREvvz85UCtUgHfHih2g1lJVr+9eI9uDzMpSh1YIzSFkcdY
         hYAtXrMu8H3q+6iueFg2WdAEgsD4ugtQsNRWc/vP8G0ieyR4C14zW4YF/O9bgwKVFP
         EEdJVvL06zCIDXNGisyAO0AzgffRJ/RdrDocj4Sq6Wp34s4DozFNC8Kgh7CK9d3oFB
         XG50JVFe9yhHA==
Date:   Wed, 5 May 2021 15:09:42 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com
Subject: Re: [PATCH v2 00/17]  Enable Qualcomm Crypto Engine on sm8250
Message-ID: <YJMXpi1V/2vTdJKD@gmail.com>
References: <20210505213731.538612-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505213731.538612-1-bhupesh.sharma@linaro.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, May 06, 2021 at 03:07:14AM +0530, Bhupesh Sharma wrote:
> 
> Tested the enabled crypto algorithms with cryptsetup test utilities
> on sm8250-mtp and RB5 board (see [1]).
> 

Does this driver also pass the crypto self-tests, including the fuzz tests
(CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y)?

- Eric
