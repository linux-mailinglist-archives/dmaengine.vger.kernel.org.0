Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A87829DE65
	for <lists+dmaengine@lfdr.de>; Thu, 29 Oct 2020 01:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732282AbgJ1WTK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Oct 2020 18:19:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731667AbgJ1WRl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:41 -0400
Received: from localhost (unknown [122.171.163.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B757C2231B;
        Wed, 28 Oct 2020 05:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603864605;
        bh=XPg4SEeqKrCMXwqHCp6LcifvhrM3ld8XV/RL6baPbrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=klApAEC0oKB+qer/j+opIGAlfrANR7UnFTZbrStUDvw5/vDWKWc46c1tpgOZz+b1a
         ogq1U35gUn+VEg9fpSAn5LCcOzrYMd7p35XBpFA4jGby1v1NG+63Dng3vUExRDJgrz
         aOxmXwc6EK46dOTK+Z8TrrXka3GBW5iVVaKAis28=
Date:   Wed, 28 Oct 2020 11:26:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] dmaengine: stm32-mdma: Use struct_size() in
 kzalloc()
Message-ID: <20201028055641.GI3550@vkoul-mobl>
References: <20201008141828.GA20325@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008141828.GA20325@embeddedor>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 08-10-20, 09:18, Gustavo A. R. Silva wrote:
> Make use of the new struct_size() helper instead of the offsetof() idiom.

Applied, thanks

-- 
~Vinod
