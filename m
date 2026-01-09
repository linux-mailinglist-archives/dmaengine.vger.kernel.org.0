Return-Path: <dmaengine+bounces-8136-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B10D06EBB
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 04:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E24330319A1
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 03:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F332322B93;
	Fri,  9 Jan 2026 03:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pqcn5xAL"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A5A243387;
	Fri,  9 Jan 2026 03:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767928036; cv=none; b=ISTXiC4FTAoHwZ3dvbFLLAdM4EOSKl7nJPkBhwW95tINN8TP6lRKNv14Vibfb2bA/esixpZtuLZT8/hRfwJ3zciDd2r0CzWeD8RXyyTRxTTuaZiLy9PkvpluslPxATIHKQfK/qzvABOe7ITUnU+BKpv8pDB1maYTVI5ePiMEAQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767928036; c=relaxed/simple;
	bh=SuA+4ZjGkTKfJszZr/F94qjYrQFU261YheQwQvC7VgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhIpVeJGyrDb4Vo0oiLvy/M8szdrcc3mtyvv5QYL/Jxkvbo2g+/UJkD+9YJu4jiSnGXZfkgg0z4j0eXPkKCS+OhombpVbWDBrhWXGyrgTv/xxwmVhoSNY0iMbKSnr6hiq0W7bcMxZ4nUUmlOTzacOcK9X7akuLw+aTCVRdIjJqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pqcn5xAL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D5DC116C6;
	Fri,  9 Jan 2026 03:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767928035;
	bh=SuA+4ZjGkTKfJszZr/F94qjYrQFU261YheQwQvC7VgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pqcn5xALsfEQBur8sts2W7grb6lheBRXWxs+Isfos4lloqU43t+b/hZUsc5h5apPn
	 DLtexPSgzr5RbFYi1QRvU9CvZ11WAY5WutKaWouarfRuh6ABHJWOtQroPfpCv8++mO
	 ut1jVC4aTf1gkfQrjYFedYI7Md9htvkR8oalTANlfzI7ps/Y5rXTkCvD7CbuD2rMS+
	 AQMhTZ6BtYs5CKMMrGiXlNa9UkFywNpZAa5zXFi9aiPjzvVzZhXy0UUMG7+E5jC4D4
	 C/ic7pYBp2rXeHrpIW2LC/cSy0TpLI1lFb6QyMBx5TCie5mTYjlEnNH4CNsAz7c+GE
	 WkMIFzVBzdcCw==
Date: Fri, 9 Jan 2026 08:37:12 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Russell King <linux@armlinux.org.uk>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	llvm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-media@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 09/11] dmaengine: fsl_raid: Simplify with scoped for
 each OF child loop
Message-ID: <aWBw4EgoaNSGrg_F@vaman>
References: <20260106-of-for-each-compatible-scoped-v2-0-05eb948d91f2@oss.qualcomm.com>
 <20260106-of-for-each-compatible-scoped-v2-9-05eb948d91f2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106-of-for-each-compatible-scoped-v2-9-05eb948d91f2@oss.qualcomm.com>

On 06-01-26, 10:15, Krzysztof Kozlowski wrote:
> Use scoped for-each loop when iterating over device nodes to make code a
> bit simpler.

Acked-by: Vinod Koul <vkoul@kernel.org>


-- 
~Vinod

