Return-Path: <dmaengine+bounces-758-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F928329BE
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jan 2024 13:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 047AD1F21DB2
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jan 2024 12:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E489C537F0;
	Fri, 19 Jan 2024 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFNSRrod"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2C9537EE;
	Fri, 19 Jan 2024 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705668646; cv=none; b=uxOP5RQhWVCBW8rtf3vwtsYRVGal7GOLslIcxFQRMbYRFvcO9xXxWAAyrXZnayu/RADwMuwE+lnNjj/EvK4Pzjg3SNCLjD4SxYXAlOJbHqS3iNZmc7JwYCRfBFGL7HWbW6j0LzRApFzHnMAuDRZVCIesVVBqSZZpTyPN/QeezNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705668646; c=relaxed/simple;
	bh=xlIMSZyr+pG3Wy3CrNH+1GCLo3e9kpzmtluEpZiOCpU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=npGcdDNCYWeDUSFJyznlJPoOoZvNsX6cmoZyfVDzCLt4ZONaaQrOWaUsY1eopnaBZp+568XQkIVMSYmUwCxlSXCIjjdoFY8UHtyOOSXHVGTEOkCQGK3GGMPqJ16wQ0rPViRKgF5fHKnC7T7xYoqhFsm38TbNlomvp5PziEzpchc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFNSRrod; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE927C433F1;
	Fri, 19 Jan 2024 12:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705668646;
	bh=xlIMSZyr+pG3Wy3CrNH+1GCLo3e9kpzmtluEpZiOCpU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CFNSRrodU01r79DCNKHvFR6MH8gQ/dh0sVuhRJ4GWIugo2B1nee/HN2M3JFsjMiL4
	 kKmFXG6yWNTPzAqD0vp73t5xi47Cf3I7qDSzLpEAI4gBmlo65zmusuHQs5grxrjx26
	 w/AySzAS9GI1wwZvMpTiHfmqU0NIpwaXYnW+x2Z6iPbgksB1R6510xkQWiH+xQO3Fn
	 iCR9rXwXBSLAJNnVJhY2oHJ5JTQPGb0Pr+ajt1/EX1mUO6zG4dN+m0KE0QKslCkzdz
	 lRnCClq5xHT7ZYDmArX4Za96HbxB23C6XnkDqLSauuPNgUDzhIaaAvJk0A/anXGyLI
	 bzwwOQEXyN58A==
From: Vinod Koul <vkoul@kernel.org>
To: lizhi.hou@amd.com, brian.xu@amd.com, raj.kumar.rampelli@amd.com, 
 michal.simek@amd.com, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jan Kuliga <jankul@alatek.krakow.pl>
Cc: kernel test robot <lkp@intel.com>
In-Reply-To: <20231222231728.7156-1-jankul@alatek.krakow.pl>
References: <20231222231728.7156-1-jankul@alatek.krakow.pl>
Subject: Re: [PATCH] dmaengine: xilinx: xdma: Fix kernel-doc warnings
Message-Id: <170566864335.152659.16974633152347136215.b4-ty@kernel.org>
Date: Fri, 19 Jan 2024 18:20:43 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Sat, 23 Dec 2023 00:17:28 +0100, Jan Kuliga wrote:
> Replace hyphens with colons where necessary.
> 
> 

Applied, thanks!

[1/1] dmaengine: xilinx: xdma: Fix kernel-doc warnings
      commit: f829bca2e294bc2953bd2dadb93d72a9987b3110

Best regards,
-- 
~Vinod



