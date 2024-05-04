Return-Path: <dmaengine+bounces-1984-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F708BBB8C
	for <lists+dmaengine@lfdr.de>; Sat,  4 May 2024 14:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A29E41C21091
	for <lists+dmaengine@lfdr.de>; Sat,  4 May 2024 12:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C934624B2A;
	Sat,  4 May 2024 12:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVXQlFz8"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A94223768;
	Sat,  4 May 2024 12:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714826841; cv=none; b=MbszsDv7SMmeldO/l4XCwcOjG+hYgYkwMzeiGQHSdgfTAYr5xox7pP3LNqy+SygtddFTlzxhYeGmU0ZKcuo9CcwY6B1ncknVwgJifNZhvohrVmhV3P7FM20UIBvxcFz4azqwf8cLQ/tAd5uwKKzP/LJmN8FisKyjmRxgetcleVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714826841; c=relaxed/simple;
	bh=DXIV8Ajg54xUGwrl5xQoCWntP/lG3fiNqOFtAtXlzs0=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GTX0dN5lGX5lHLYZ607FoGS+6B9+geca25QRkLcN4BGDHqWW3UBY/Kvs33V0ovsuev7dvL4Cguk4VmIYvbrdl+Nqm5kagyGMbU+U6ot04DCnIt5hTuL0x+qP08SHzK+EwuAwkH6j/Z2Sqs8xnhoWObLNjGUWDOe1UZmFBi7tnNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVXQlFz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EABEC32789;
	Sat,  4 May 2024 12:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714826841;
	bh=DXIV8Ajg54xUGwrl5xQoCWntP/lG3fiNqOFtAtXlzs0=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=MVXQlFz8S36yZ29LUbRhjMMdQXAxAWdVVWGT0Z9kEoFdEoNTDF8H+bht0y2XRsNs7
	 JWrTwBphom8j4JEieqDRwAdgEpVNKwymxsKqyozCrjHFjCQsCdUeOWLcPl/YRm4y/b
	 4Xi1Rr4NTCs7u55IkxxAPBVZCrp4zGbXgbvFbbBpr0azzpI5WVe/mraS/FB+d7Rt94
	 /bYyrOFjnKzrA6mg3kb3JxN8G+Uq24OyKommzlqTipRf6W7azvwo8ynFtCBFfTffsR
	 qYyIFsro4+/qNcReLSr+TuV0Alz/4OD3ScoKzg8pl/A4KVvAL6MHWZJNnCWvgcpiHq
	 C6gnFsDW5IEqA==
From: Vinod Koul <vkoul@kernel.org>
To: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20240425205947.3436501-1-Frank.Li@nxp.com>
References: <20240425205947.3436501-1-Frank.Li@nxp.com>
Subject: Re: [PATCH resend v2 1/2] dmaengine: fsl-edma: add trace event
 support
Message-Id: <171482683862.61200.3543162148373426245.b4-ty@kernel.org>
Date: Sat, 04 May 2024 18:17:18 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 25 Apr 2024 16:59:45 -0400, Frank Li wrote:
> Implement trace event support to enhance logging functionality for
> register access and the transfer control descriptor (TCD) context.
> This will enable more comprehensive monitoring and analysis of system
> activities
> 
> 

Applied, thanks!

[1/2] dmaengine: fsl-edma: add trace event support
      commit: 11102d0c343ba06ddd303f2503c0ce46d70052f2
[2/2] dmaengine: fsl-edma: use _Generic to handle difference type
      commit: 3f2282931f00c4c9c5057bb02f46778ba64ff625

Best regards,
-- 
~Vinod



