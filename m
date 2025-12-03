Return-Path: <dmaengine+bounces-7483-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8C3C9EBE9
	for <lists+dmaengine@lfdr.de>; Wed, 03 Dec 2025 11:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0FA2A3478D6
	for <lists+dmaengine@lfdr.de>; Wed,  3 Dec 2025 10:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657BF2EE5F4;
	Wed,  3 Dec 2025 10:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="et4xYk5h"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321732ED860;
	Wed,  3 Dec 2025 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764758369; cv=none; b=LUpi/5qWbeaeIPIiEfWaKOo/sfuxldFPKWHWDBiPDsaguhT8VkaJYu3rDJ42S4F35Wh20a7JlIdheY5ZtTLQiVK3ygRuFRejxTYIPSV3oxtWTz+TTSMewIv6gxmJY74OJ+9rATvzu2qerwCiV5MybiAPqD416GfPjHT9owNjccg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764758369; c=relaxed/simple;
	bh=TLBlsGSLsSIAD6kDe9cUxlU+9iuTV0gMwtHNAzccloc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkKOjBSApyJBKsVitSXjoP4aKlyFE/wPV+Atq2M1AjhO1c4jqGuaud+95sgYqwnvFNF6Dn2MMwbbbYNrM9AWX/Xt3cZUjR7xn9Etx+lVXQOxmzSkIqG+GMgCbSzI87PLXOC/1Up5jtBRmdd6qPF7iOuZ5z9u+TkBIQZTcSlctO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=et4xYk5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F189C4CEFB;
	Wed,  3 Dec 2025 10:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764758368;
	bh=TLBlsGSLsSIAD6kDe9cUxlU+9iuTV0gMwtHNAzccloc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=et4xYk5h44EL2L+Ku72VBPYS4J8Y+XWKAj7xjtSPfXIneLcslFxUXA+iSrCZBaMzk
	 466J15UKAhQp94skS0BrJJ3GxkoEW3evFGBFFpu5AFzpP/fTC06DaQx0K0kEhK8ZVC
	 mMW8bkmW4hjWBAarxAOHEDVQ7y56B8Bxx4wtlCcDjhch3SHlnqhfKMreANVUCN2e+I
	 rYHZ8LcpBvT6x1nD9t0ccH+oDcQexzyjDd+gl+1VJ888aDyoeujrPkjPfSdl0SL2O8
	 O3MTOWYKXc0ouvbTfep9Ys0pg3hFYkdEwNe2lmy16YrR7RuFXLDIvnJaII2WCaT1AM
	 HE5wk0CK/K4cQ==
Date: Wed, 3 Dec 2025 11:39:21 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Frank Li <Frank.li@nxp.com>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, mani@kernel.org,
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
	corbet@lwn.net, vkoul@kernel.org, jdmason@kudzu.us,
	dave.jiang@intel.com, allenbh@gmail.com, Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com,
	logang@deltatee.com, jingoohan1@gmail.com, lpieralisi@kernel.org,
	robh@kernel.org, jbrunet@baylibre.com, fancer.lancer@gmail.com,
	arnd@arndb.de, pstanner@redhat.com, elfring@users.sourceforge.net,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [RFC PATCH v2 19/27] PCI: dwc: ep: Cache MSI outbound iATU
 mapping
Message-ID: <aTATWZaiqwNfwymD@ryzen>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-20-den@valinux.co.jp>
 <aS39gkJS144og1d/@lizhi-Precision-Tower-5810>
 <ddriorsgyjs6klcb6d7pi2u3ah3wxlzku7v2dpyjlo6tmalvfw@yj5dczlkggt6>
 <aS6yIz94PgikWBXf@ryzen>
 <pxvbohmndr3ayktksocqhzhgxbmvpibg3kixqgch2grookrvgq@gx3iqjcskjcu>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pxvbohmndr3ayktksocqhzhgxbmvpibg3kixqgch2grookrvgq@gx3iqjcskjcu>

On Wed, Dec 03, 2025 at 05:40:45PM +0900, Koichiro Den wrote:
> > 
> > If we want to improve the dw-edma driver, so that an EPF driver can have
> > multiple outstanding transfers, I think the best way forward would be to create
> > a new _prep_slave_memcpy() or similar, that does take a direction, and thus
> > does not require dmaengine_slave_config() to be called before every
> > _prep_slave_memcpy() call.
> 
> Would dmaengine_prep_slave_single_config(), which Frank tolds us in this
> thread, be sufficient?

I think that Frank is suggesting a new dmaengine API,
dmaengine_prep_slave_single_config(), which is like
dmaengine_prep_slave_single(), but also takes a struct dma_slave_config *
as a parameter.


I really like the idea.
I think it would allow us to remove the mutex in nvmet_pci_epf_dma_transfer():
https://github.com/torvalds/linux/blob/v6.18/drivers/nvme/target/pci-epf.c#L389-L429

Frank you wrote: "Thanks, we also consider ..."
Does that mean that you have any plans to work on this?
I would definitely be interested.


Kind regards,
Niklas

