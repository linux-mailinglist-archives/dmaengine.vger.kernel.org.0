Return-Path: <dmaengine+bounces-5415-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0B2AD6E95
	for <lists+dmaengine@lfdr.de>; Thu, 12 Jun 2025 13:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14F3D7AE05B
	for <lists+dmaengine@lfdr.de>; Thu, 12 Jun 2025 11:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA11E17A2EA;
	Thu, 12 Jun 2025 11:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fxJDxrI9"
X-Original-To: dmaengine@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C157A238C3B;
	Thu, 12 Jun 2025 11:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749726354; cv=none; b=VCb5kAJu/XCYsob01HrLwbgRqg14HiEIEuAaLxzHaHPtQYL4doREP/rAlHff5lDMaCqgKMV3iowV5GwlzTISCvy4Qek1P0lhqpFDckXIqCdRvQoqbeUh9P36shuvsqhitQrTdHJWMzgC6YwpzKb3VFqO4BTxuu1Sx9YzCCkrlbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749726354; c=relaxed/simple;
	bh=RDVb19xxFHSj+C5sinLQCxAAgDhQxroXOYkiUH+Qd4g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQ5L6u++aG/BeKk4aLWL2ha3HGDrd+49oxrFmXgfzx/0UDks3edXu55znofBf4J4giM5HyCz1Hz2XkVyjWnRZDVO/PMk0IuCkxf8gTFbEqSMDYoHsn/UYfVCZVt0FY4hPi9wot0ntk+QxDIMuIvC+TPoZVKJh+7PgJN8ZvPMaKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fxJDxrI9; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55CB5hd92898988;
	Thu, 12 Jun 2025 06:05:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1749726343;
	bh=O+6Lsaau/SvLorn3/KuyZs0zfk4cChLknIsmfvwpl2A=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=fxJDxrI9Fq+6OuWJw5UeXo1W6YnR+zWvsvi+svR9gf9goaxzkk6AuSVsFeoWPrZYe
	 84rOkvasz7vdXxDxllCtpok7rIJCitKHngVWxn6qgqIW9EradsEp3pCjDKLQjiYeLZ
	 V4Xf0WfT2XU3fk2JqI12mBG/iW2PBoC+vxh2ZZuU=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55CB5hUj2534115
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 12 Jun 2025 06:05:43 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 12
 Jun 2025 06:05:43 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 12 Jun 2025 06:05:43 -0500
Received: from localhost (dhcp-172-24-227-169.dhcp.ti.com [172.24.227.169])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55CB5gsw1886634;
	Thu, 12 Jun 2025 06:05:42 -0500
Date: Thu, 12 Jun 2025 16:35:42 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>
CC: Peter Ujfalusi <peter.ujfalusi@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Santosh
 Shilimkar <ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <praneeth@ti.com>,
        <vigneshr@ti.com>, <u-kumar1@ti.com>, <a-chavda@ti.com>,
        <p-mantena@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v2 03/17] dmaengine: ti: k3-udma: move static inline
 helper functions to header file
Message-ID: <acc1217d-50ce-4851-829d-38294b0a4d81@ti.com>
References: <20250612071521.3116831-1-s-adivi@ti.com>
 <20250612071521.3116831-4-s-adivi@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250612071521.3116831-4-s-adivi@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Thu, Jun 12, 2025 at 12:45:07PM +0530, Sai Sree Kartheek Adivi wrote:
> Move static inline helper functions in k3-udma.c to k3-udma.h header
> file for better separation and re-use.
> 
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
>  drivers/dma/ti/k3-udma.c | 108 --------------------------------------
>  drivers/dma/ti/k3-udma.h | 109 +++++++++++++++++++++++++++++++++++++++

Since this patch and the previous two patches seem to have the same
objective of moving contents from "k3-udma.c" to "k3-udma.h" for the
purpose of re-use, could they be squashed?

Regards,
Siddharth.

