Return-Path: <dmaengine+bounces-5688-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3087FAEEB97
	for <lists+dmaengine@lfdr.de>; Tue,  1 Jul 2025 02:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77BBC188AB2A
	for <lists+dmaengine@lfdr.de>; Tue,  1 Jul 2025 00:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E34176AC8;
	Tue,  1 Jul 2025 00:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfuoHebJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D10339A1;
	Tue,  1 Jul 2025 00:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751331540; cv=none; b=Wx7lsQUWP0DB/qjS1yIXmmofNROyyfnrxgNsH2EBupBpdhGKOLW61nzpha6G28hL6wMtAUL0Uu3w8tmby7JwW3Srmwu5r0tDS+uvPHDBIv5DJefjouOVzVLoh5Wlqdxn1YQkVf7FWuowTIvR2CJ4I0PzkOLmQpeIltoW9jfvYWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751331540; c=relaxed/simple;
	bh=9HxcNJuEn6U3HrXpUgYLdxw3kgdJpz+DEj6DfdRZ+No=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=J1MYS/p7UQm39NaMR5Gs6fE++bPk6em4ESEavRJoqg+3CaomxT6QjTDDpmVTxedcG3UURqnSY/OnMTrXSRMLLuQ5M4dzs6kg9pLyg9aqyjZoU2WBoZU1FQvWWJMX772Nwfk1bYjx/5w0ESydYDpeDqNPkZ2yBJDFyjobxTKY4Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfuoHebJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D9FC4CEF1;
	Tue,  1 Jul 2025 00:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751331540;
	bh=9HxcNJuEn6U3HrXpUgYLdxw3kgdJpz+DEj6DfdRZ+No=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=GfuoHebJKKFhQTGMT+1ui1B4Dt/61GVe0XlSWy7uxDMx6SCDLTyIUQzADGhVDCPfH
	 UlRTEn+DgR18Qp+AUQUnZwXX2aBYYFPGPG0Q3y1s3PNc6035lPpKIpuSL/6mAce23Y
	 9aHomLoISVnmlNYSa6j7PywA1iHdnEKjmEeSnxiS4HZ2swKdz4TBEgkAWlMegVKeaq
	 PFjvtkREDiEcHFbqxCPQ/2Mch8ktj6RjXATfOZlIczCV9qyImrMRiD77xj0v4IndyA
	 R1LS//enUSfHxL/ZVnSteCr37lJZ+ps7TL/EsG1HDbizIsuVmC2jb9p/kexLDKFWcJ
	 soCg50fzVQXuw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250519-dev-axi-clkgen-limits-v6-4-bc4b3b61d1d4@analog.com>
References: <20250519-dev-axi-clkgen-limits-v6-0-bc4b3b61d1d4@analog.com> <20250519-dev-axi-clkgen-limits-v6-4-bc4b3b61d1d4@analog.com>
Subject: Re: [PATCH v6 4/7] include: adi-axi-common: add new helper macros
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, Vinod Koul <vkoul@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Trevor Gamblin <tgamblin@baylibre.com>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, Mike Turquette <mturquette@linaro.org>
To: Nuno =?utf-8?q?S=C3=A1?= via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>, dmaengine@vger.kernel.org, linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org, nuno.sa@analog.com
Date: Mon, 30 Jun 2025 17:59:01 -0700
Message-ID: <175133154149.4372.12524625189778577779@lazor>
User-Agent: alot/0.11

Quoting Nuno S=C3=A1 via B4 Relay (2025-05-19 08:41:09)
> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> Add new helper macros and enums to help identifying the platform and some
> characteristics of it at runtime.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---

Applied to clk-next

