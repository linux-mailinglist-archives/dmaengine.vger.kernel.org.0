Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1193AD5D06
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2019 10:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfJNICY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Oct 2019 04:02:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:49518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729928AbfJNICY (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 14 Oct 2019 04:02:24 -0400
Received: from localhost (unknown [122.167.124.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCB2E20650;
        Mon, 14 Oct 2019 08:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571040143;
        bh=gjZ84eYSKyLRBQDVS9KkAvi+i1YmiBvyGp7N1fgos5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KvNVoXYnE0Q/XbEnPebDW7zr35L3h2rMEjoshhFGj9G1vtitr68yRsxgzF774tF9v
         gHgeSDlq6C6KyhQsnW5FfGO2DdV4mB7KouXRCTwqOOcHXypFbfInX0bYAf5/XhCw2x
         QRKuqxaIJSz4+Zhoma8EH8FyaZ9z0wAbEWjERpzo=
Date:   Mon, 14 Oct 2019 13:32:15 +0530
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
Message-ID: <20191014080215.GL2654@vkoul-mobl>
References: <1569347584-3478-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569347584-3478-1-git-send-email-yibin.gong@nxp.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-09-19, 09:49, Robin Gong wrote:
> Illegal memory will be touch if SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V3
> (41) exceed the size of structure sdma_script_start_addrs(40),
> thus cause memory corrupt such as slob block header so that kernel
> trap into while() loop forever in slob_free(). Please refer to below
> code piece in imx-sdma.c:
> for (i = 0; i < sdma->script_number; i++)
> 	if (addr_arr[i] > 0)
> 		saddr_arr[i] = addr_arr[i]; /* memory corrupt here */
> That issue was brought by commit a572460be9cf ("dmaengine: imx-sdma: Add
> support for version 3 firmware") because SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V3
> (38->41 3 scripts added) not align with script number added in
> sdma_script_start_addrs(2 scripts).

Applied, thanks

-- 
~Vinod
