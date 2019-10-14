Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85702D5D7E
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2019 10:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730448AbfJNIav (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Oct 2019 04:30:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfJNIau (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 14 Oct 2019 04:30:50 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5443B207FF;
        Mon, 14 Oct 2019 08:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571041850;
        bh=p7mjM/EcKkarwYBL8yjO5OkJb2HPOW4/n1CL+uOOlMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RTnfmVLrzT1mElpLV1XpxtXmAYaHC4vXjDk1D8B2kTsZLHBXEuOXdUn57LgcXb0Ej
         h3mpF2mTZzuwOHBrv9gd3TZkQ4d/61IzyEHJNqi+GNSCzH6D3Q9rxbNjPNVhwsqsHm
         enxUHSuGte972ZNKUuW2YUasfYnn5BuldVKKqFww=
Date:   Mon, 14 Oct 2019 16:29:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        frowand.list@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        xen-devel@lists.xenproject.org, linux-tegra@vger.kernel.org,
        linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>, mbrugger@suse.com,
        robin.murphy@arm.com, f.fainelli@gmail.com,
        james.quinlan@broadcom.com, wahrenst@gmx.net,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 08/11] dts: arm64: layerscape: add dma-ranges property to
 pcie nodes
Message-ID: <20191014082924.GI12262@dragon>
References: <20190924181244.7159-1-nsaenzjulienne@suse.de>
 <20190924181244.7159-9-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924181244.7159-9-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Sep 24, 2019 at 08:12:39PM +0200, Nicolas Saenz Julienne wrote:
> The bus behind the board's PCIe core has DMA addressing limitations. Add
> an empty 'dma-ranges' property on all PCIe bus descriptions to inform
> the OF core that a translation is due further down the line.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Applied, thanks.
