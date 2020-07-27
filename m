Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B846822E83C
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jul 2020 10:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgG0IxR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jul 2020 04:53:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbgG0IxR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 Jul 2020 04:53:17 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6610820719;
        Mon, 27 Jul 2020 08:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595839997;
        bh=va0aIl9wCbBDl+QAAonRZejZr/UBGIItQ+XxDiXf+OU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PiAfnr0pA4oT7XOukrOPAMJ1NkUVdvUMDMQWMRXHDehK/YKTIXJuS5M+8RVDML2PM
         blXAa9P+YDuXPZ7M0eEu3OhHAtusQfoeQv5PMycQglNfS7AG1Ewi6bi7maTlMhWrGW
         Nr7B6XY3JJUvqsYd3JuEksQfL/qVSubqK6hv12n0=
Date:   Mon, 27 Jul 2020 14:23:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, dan.j.williams@intel.com
Subject: Re: [PATCH 0/2] dmaengine: ti: k3-udma: Get supported throughput
 levels from hardware
Message-ID: <20200727085313.GK12965@vkoul-mobl>
References: <20200717120903.8774-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717120903.8774-1-peter.ujfalusi@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-07-20, 15:09, Peter Ujfalusi wrote:
> Hi,
> 
> Newer versions of UDMAP have information on the number of different throughput
> channels in it's CAP registers.
> 
> The driver can auto configure based on the information from the hardware isntead
> a table within the match_data.
> 
> With this change we can use the same compatible string for identical versions of
> UDMAP when only the number of UHCHAN and HCHAN is different.

Applied, thanks

-- 
~Vinod
