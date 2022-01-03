Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B355948308B
	for <lists+dmaengine@lfdr.de>; Mon,  3 Jan 2022 12:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbiACLbw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Jan 2022 06:31:52 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44578 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiACLbw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Jan 2022 06:31:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1926160FF8;
        Mon,  3 Jan 2022 11:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6360C36AEF;
        Mon,  3 Jan 2022 11:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641209511;
        bh=9FXcqtuTP1D+DsrKHdYUPmtDBir5oMq0sYMH5fyS8rk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yvd1CIwtECNLPt3kZLF/JCTIOPiSgwMMeRX0MQKVhRuiPAMygvsKuV1QOHumkuTvP
         UyM7xKl11oFX/Bsj/Fn89pCnHOkFz7+lqWmkX+nup/a0gvgTZAdFpBgmDHnT4durI4
         HWeT/OtakmBlUU2tZowzaihdLbNBNczNgCioKE/1GZ/D/dF+pwoa+RQs0RomORKwgx
         rM+VUADe9edJa41kIl+M5nChTJhn2WbYC/MifazXq55cXejrdoLCbC7k/aSQzP5hzY
         eL93BwjpcqPet8eZYLcr8Jx1G4/w/CJJDN/EQjp6qympN5U88thHlXyS1JuPm8FF9b
         vsouicC4XrUXw==
Date:   Mon, 3 Jan 2022 17:01:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: pl330: Convert to DT schema
Message-ID: <YdLeo+rMbiLG1FOF@matsya>
References: <20211217170644.3145332-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217170644.3145332-1-robh@kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-12-21, 11:06, Rob Herring wrote:
> Convert the Arm PL330 DMA controller binding to DT schema.
> 
> The '#dma-channels' and '#dma-requests' properties are unused as they are
> discoverable and are non-standard (the standard props don't have '#'). So
> drop them from the binding.

Applied, thanks

-- 
~Vinod
