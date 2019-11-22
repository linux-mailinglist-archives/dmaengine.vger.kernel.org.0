Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35258106065
	for <lists+dmaengine@lfdr.de>; Fri, 22 Nov 2019 06:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfKVFqo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Nov 2019 00:46:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:52668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfKVFqo (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 22 Nov 2019 00:46:44 -0500
Received: from localhost (unknown [171.61.94.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF07620708;
        Fri, 22 Nov 2019 05:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401603;
        bh=VWM3Q3Z9EQMH2J5HNYYlrQp180EOX7v3YY8cFRmcotE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wRH0+VSORrFjJLBOu6/d+/2plTHQWP3YeCW37FIW3YpVpcA9GzfOv+ZV88P1QmSFE
         8tdLsNVtFK2rSehC8/vmBVpU/HK2ua+1IKkaL/xGPD1A2N/aHg2FwWNGDXZV1TRINL
         yVz1Mb9FhLJZ7aEs6ygkH47nM9G2msGXiK9MkDwQ=
Date:   Fri, 22 Nov 2019 11:16:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: Fix Kconfig indentation
Message-ID: <20191122054639.GT82508@vkoul-mobl>
References: <1574306348-29212-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574306348-29212-1-git-send-email-krzk@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-11-19, 04:19, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig

Applied, thanks

-- 
~Vinod
