Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAE829DE95
	for <lists+dmaengine@lfdr.de>; Thu, 29 Oct 2020 01:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgJ2AzN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Oct 2020 20:55:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731660AbgJ1WRk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:40 -0400
Received: from localhost (unknown [122.171.163.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D97322202;
        Wed, 28 Oct 2020 06:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603866130;
        bh=gzosteGez+/wyh3KkqsORUm0XHXn7trWdT/tSA8zO5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ztXFBNZlejzPGglUMn8+MiHggOZPjpi4OWmbhoTViQOOyZu5IjRSd+8lzLloe0N9J
         HAwE5vwnS+6UhZnTSB/0lsgARMG+pZmGLUZmkKgfkyzn4WdA1B00h3h0H0XB5CxScn
         0yInRNyATpN5ZSEibURHRliFholg7w8OljSPABlg=
Date:   Wed, 28 Oct 2020 11:52:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     robh+dt@kernel.org, nicolas.ferre@microchip.com,
        tudor.ambarus@microchip.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: dmaengine: at_xdmac: add compatible
 with microchip,sama7g5
Message-ID: <20201028062206.GM3550@vkoul-mobl>
References: <20201016081754.288488-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016081754.288488-1-eugen.hristev@microchip.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-10-20, 11:17, Eugen Hristev wrote:
> Add compatible to sama7g5 SoC.

Applied all, thanks

Btw the threading was broken in this series, please do ensure that
patches are threaded properly.

-- 
~Vinod
