Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8C2D5D1B
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2019 10:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbfJNIFt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Oct 2019 04:05:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfJNIFt (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 14 Oct 2019 04:05:49 -0400
Received: from localhost (unknown [122.167.124.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EC802054F;
        Mon, 14 Oct 2019 08:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571040348;
        bh=JMX1LApY2fbKeVzv4AKmUzSaxbEE2mGrMc7ILY5Utmc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0HX2BXwBBUVV6EdFcDo4PS3xZqvONejrn/66/Ku4UC2V64qZHV/jxFo+KCNiX6hlm
         Bo0H90rxwYt9Gfhi5DTuBZjNx5l3SP+sAE1qPoUNivDYdOBs5i3rf/jwZVV55t3fe2
         pHNsxzdfIhJtHxQuNRZDdojM3EnLMsDbsASy6uv8=
Date:   Mon, 14 Oct 2019 13:35:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "J.Lambrecht@TELEVIC.com" <J.Lambrecht@televic.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] dmaengine: imx-sdma: fix kernel hangs with SLUB slab
 allocator
Message-ID: <20191014080544.GM2654@vkoul-mobl>
References: <1569347584-3478-1-git-send-email-yibin.gong@nxp.com>
 <20191014080215.GL2654@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014080215.GL2654@vkoul-mobl>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-10-19, 13:32, Vinod Koul wrote:
> On 24-09-19, 09:49, Robin Gong wrote:
> > Illegal memory will be touch if SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V3
> > (41) exceed the size of structure sdma_script_start_addrs(40),
> > thus cause memory corrupt such as slob block header so that kernel
> > trap into while() loop forever in slob_free(). Please refer to below
> > code piece in imx-sdma.c:
> > for (i = 0; i < sdma->script_number; i++)
> > 	if (addr_arr[i] > 0)
> > 		saddr_arr[i] = addr_arr[i]; /* memory corrupt here */
> > That issue was brought by commit a572460be9cf ("dmaengine: imx-sdma: Add
> > support for version 3 firmware") because SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V3
> > (38->41 3 scripts added) not align with script number added in
> > sdma_script_start_addrs(2 scripts).
> 
> Applied, thanks

And after applying I noticed the patch title is not apt. The patch title
should reflect the change and not the cause or result.

So I have modified the title to: "dmaengine: imx-sdma: fix size check
for sdma script_number"

Thanks
-- 
~Vinod
