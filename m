Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E10282FEC
	for <lists+dmaengine@lfdr.de>; Mon,  5 Oct 2020 06:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbgJEE4X (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Oct 2020 00:56:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgJEE4X (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 5 Oct 2020 00:56:23 -0400
Received: from localhost (unknown [171.61.67.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDCEE2080C;
        Mon,  5 Oct 2020 04:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601873472;
        bh=Z/SwT7c4Ve1srrsUK9mb3041zwltNCWOLNkG6scitrs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cQL2XHhkne8ckjnANwCRPDemlSUxko1OQThKFGgqUfRtZzaoOBwCSrwiLpIqxG6t0
         IOdmRDdwsJumfHC9nwk8eNnXL5NhRLfG9aYPrLvT/GVRLQc1WRecxKUieJgdb5Fbc1
         T+yxjX3GG7Wn81V/7YZU7MZHK9wMgvzarD148p2I=
Date:   Mon, 5 Oct 2020 10:21:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michal Simek <michal.simek@xilinx.com>,
        dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Fix 'reg' size issues in zynqmp examples
Message-ID: <20201005045108.GL2968@vkoul-mobl>
References: <20200928155953.2819930-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928155953.2819930-1-robh@kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-09-20, 10:59, Rob Herring wrote:
> The default sizes in examples for 'reg' are 1 cell each. Fix the
> incorrect sizes in zynqmp examples:
> 
> Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.example.dt.yaml: example-0: dma-controller@fd4c0000:reg:0: [0, 4249616384, 0, 4096] is too long
> 	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
> Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.example.dt.yaml: example-0: display@fd4a0000:reg:0: [0, 4249485312, 0, 4096] is too long
> 	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
> Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.example.dt.yaml: example-0: display@fd4a0000:reg:1: [0, 4249526272, 0, 4096] is too long
> 	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
> Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.example.dt.yaml: example-0: display@fd4a0000:reg:2: [0, 4249530368, 0, 4096] is too long
> 	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
> Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.example.dt.yaml: example-0: display@fd4a0000:reg:3: [0, 4249534464, 0, 4096] is too long
> 	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml

Applied, thanks

-- 
~Vinod
