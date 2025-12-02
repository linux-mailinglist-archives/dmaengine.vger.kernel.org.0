Return-Path: <dmaengine+bounces-7456-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D3BC9A50D
	for <lists+dmaengine@lfdr.de>; Tue, 02 Dec 2025 07:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B1E963460B9
	for <lists+dmaengine@lfdr.de>; Tue,  2 Dec 2025 06:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C1F2F9DA4;
	Tue,  2 Dec 2025 06:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2G5IvJl"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A9E24E4C4;
	Tue,  2 Dec 2025 06:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764657161; cv=none; b=bFOwQCEYLKkFI1soiVnL9EnkXCiX4DBPGXcegktwzR7lc7elAZ10aAIHvtA29i1mYYwjQqaudUOD+hr874VFUxjSxmk1+9+Dvk5FcMdLHhiJSjtPJ3lpAuu85+oKLW1Ux2EZPoEHKfB3gvLd5v1HCWuJnufrCsChSZnoqsQ4DiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764657161; c=relaxed/simple;
	bh=TgEB8wVKZ5xbL1Enc85Hn5PeEqpdms/JqisfACwfnkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4egqqbaXAr5BGXfG462aIhshXZwKhZtZbX0AsazZ/9v2zavUdHWgWLDnFyHepg4QfQ0xnwX3mQZNqjgPfskK/0+j56oXv4g9LqvUVukEun8ScRTK2zgvC2lRUU7WmbDBdk+vicC0j8qY70+1HzX+mSZBOUYEZ3Fzbz1a4Dy7I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2G5IvJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD00EC4CEF1;
	Tue,  2 Dec 2025 06:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764657160;
	bh=TgEB8wVKZ5xbL1Enc85Hn5PeEqpdms/JqisfACwfnkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z2G5IvJlG159Qtj2L1uCxdVh489iCJxiCAEBCgUbF2645xJTjuQtWbvjOJbQBMJbb
	 pv1mrDCrAixL6k/XD8MOkbjs67npdwzqiXDAigqBj+s/DyXqux9lUsM3YHN/34YRQG
	 VOHvCL6AcPSwyhqMhGlEl0nFqx45syiziWX9s/HWUr2/BP6JapD7PpSkwxN7T/6+s0
	 BStRwP3JQp7dUAqtAJRMBi7KCRnE1FZ7Lg6vYpioozogzxQ1tDv7SDCMoHsdmEyQbL
	 JiePoQ6D1tBcJB3zws78jhNCTPdI5h5zt3D/LzNUAL2ZD/GseuiLuOWy8lcIhB5LDz
	 c/xc2mEgwjZVQ==
Date: Tue, 2 Dec 2025 07:32:31 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank.Li@nxp.com, mani@kernel.org, kwilczynski@kernel.org,
	kishon@kernel.org, bhelgaas@google.com, corbet@lwn.net,
	vkoul@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com,
	allenbh@gmail.com, Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com,
	logang@deltatee.com, jingoohan1@gmail.com, lpieralisi@kernel.org,
	robh@kernel.org, jbrunet@baylibre.com, fancer.lancer@gmail.com,
	arnd@arndb.de, pstanner@redhat.com, elfring@users.sourceforge.net,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [RFC PATCH v2 19/27] PCI: dwc: ep: Cache MSI outbound iATU
 mapping
Message-ID: <aS6H_6gBEQjmQUG0@ryzen>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-20-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129160405.2568284-20-den@valinux.co.jp>

On Sun, Nov 30, 2025 at 01:03:57AM +0900, Koichiro Den wrote:
> dw_pcie_ep_raise_msi_irq() currently programs an outbound iATU window
> for the MSI target address on every interrupt and tears it down again
> via dw_pcie_ep_unmap_addr().
> 
> On systems that heavily use the AXI bridge interface (for example when
> the integrated eDMA engine is active), this means the outbound iATU
> registers are updated while traffic is in flight. The DesignWare
> endpoint spec warns that updating iATU registers in this situation is
> not supported, and the behavior is undefined.

Please reference a specific section in the EP databook, and the specific
EP databook version that you are using.

This patch appears to address quite a serious issue, so I think that you
should submit it as a standalone patch, and not as part of a series.

(Especially not as part of an RFC which can take quite long before it is
even submitted as a normal (non-RFC) series.)


Kind regards,
Niklas

