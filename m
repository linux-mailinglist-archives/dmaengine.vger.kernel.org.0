Return-Path: <dmaengine+bounces-3217-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04599877A1
	for <lists+dmaengine@lfdr.de>; Thu, 26 Sep 2024 18:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A58DE1C22B4A
	for <lists+dmaengine@lfdr.de>; Thu, 26 Sep 2024 16:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34093156C40;
	Thu, 26 Sep 2024 16:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJWIDfQi"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B1312BEBB;
	Thu, 26 Sep 2024 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727368620; cv=none; b=ASWskJdqojKnDDXh6nlrYWb0lfNHl/xu26v7CyLB12Q3t8GPo5OmQn1X5rPRntwm3yO7xJX2eku4vRzTbDnmRnFK9lebPyYxf8oe3I+DGgj7b7+vttQfPXxT7jvdu9trIsNGNdqGiTr+cMuCLJBr1Um81piXPnfMlU9P9evRmcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727368620; c=relaxed/simple;
	bh=w1FJdKOm32c+Ge8FTW9mqPZjuB6KQQTcj8OAX5YmD4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkZ5qREBmwl+s7E12XwYPuULtTauWy/qh9/VM3nxeqSZ0IkZSaYn/FOaXsoQVVbU0QjMrvb9cBU/6znPgpq+4FgSKQKS4ygD1ad8ntm6134kaJkf5I1LNNXn0iZNcqk4BDGo7lF6PpP1vC15H0GSDeZ7DfutXc61zn7tLgs+3k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJWIDfQi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC584C4CEC5;
	Thu, 26 Sep 2024 16:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727368619;
	bh=w1FJdKOm32c+Ge8FTW9mqPZjuB6KQQTcj8OAX5YmD4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TJWIDfQiU3geDX/2aC7h48yAL5lr4yBVoaHkFfIiMG2WxAK9jVbdT8d0DDKwwCfrU
	 VgGEIMqGfYackuRbizXofkLgd3uwft1kELY7e8nW7oXy8tmugyRHDWlMXuLKrDiVRB
	 4M+3Y0chGvD5CO/8hcYvhpmKffIvMleF1oZ76l0SCGdRoQ2LTzThDA4hci6c67GzCc
	 UK29Sg2RR10ZjRqupgOeZK0+tCRHrpLtvLrO7e0xfItdeyN6G1jquRpAoM4/xDTgfX
	 WmDpEC2Nqz4UvKwHtHtbm94EG0WKQxNunbFiwUfrfN1n8FUtRUNpXc6nebKIN3c6fP
	 dd6gOhBKhV6UQ==
Date: Thu, 26 Sep 2024 17:36:51 +0100
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Paul Elder <paul.elder@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Jim Quinlan <james.quinlan@broadcom.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-media@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Fix array property constraints
Message-ID: <20240926-bullion-semester-024fab878903@spud>
References: <20240925232409.2208515-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uWcwIitsRojZdEUY"
Content-Disposition: inline
In-Reply-To: <20240925232409.2208515-1-robh@kernel.org>


--uWcwIitsRojZdEUY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 06:24:06PM -0500, Rob Herring (Arm) wrote:
> Schemas for array properties should only have 1 level of array
> constraints (e.g. items, maxItems, minItems). Sometimes the old
> encoding of all properties into a matrix leaked into the schema, and
> didn't matter for validation. Now the inner constraints are just
> silently ignored as json-schema array keywords are ignored on scalar
> values.
>=20
> Generally, keep the inner constraints and drop the outer "items". With
> gicv3 "mbi-alias" property, it is more appropriately a uint32 or uint64
> as it is an address and size depends on "#address-cells".
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--uWcwIitsRojZdEUY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvWNowAKCRB4tDGHoIJi
0uo/AQCSoUq76yV2zPjc/Dv0ex3UOkszyyKeTqzAyCiuqne2QAD/WOq25LSaE13W
/Ok8UcwWwBnHRPHDLu6I17O3OvhLEAk=
=PPnK
-----END PGP SIGNATURE-----

--uWcwIitsRojZdEUY--

