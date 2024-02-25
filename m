Return-Path: <dmaengine+bounces-1105-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D321862CBA
	for <lists+dmaengine@lfdr.de>; Sun, 25 Feb 2024 21:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86DD1F22009
	for <lists+dmaengine@lfdr.de>; Sun, 25 Feb 2024 20:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45B01B807;
	Sun, 25 Feb 2024 20:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NPUeLmKO"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF181B800;
	Sun, 25 Feb 2024 20:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708891914; cv=none; b=dYBXw37otS2m5AaJRLXC6nazTIJKZr5CbPtOXd3c2DY8Yzf328B6S+pudPq/fL72u4707YF5VNgmdV8qAp74y9mLTaWrh2pOGmbm7gv+vbI4Khctd2TdcNtFWcFoxvws220llNqkHe60phD0whrT7GSCHuXSIO3FmnvUAXE+oKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708891914; c=relaxed/simple;
	bh=ipeSeJEnGh8gKOqj8bEZj+meMRjyyaDgYj/HDJhNvV0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gsOdmyV2XBfDv4lNsdmdsxLTNwvxPSSVN8lidpidKfIjKXJFUMpbRsa/zTrl85nN2jjUjqLMlZDOItM2R6qcTo1qGRAdtOur4/g0emQLHTIZ62/v0fTdYFyovltBZj0UIunR54Gkcg0MlS0TiQKG3SEB7OYgIhqdsFKGkAW3C0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NPUeLmKO; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708891914; x=1740427914;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ipeSeJEnGh8gKOqj8bEZj+meMRjyyaDgYj/HDJhNvV0=;
  b=NPUeLmKO+oRNw2j2I4podqsa05LUZNdy1I5QTqob6jBEMU9AsbkZzfLn
   /pwAOTYMegkHOE4xOp65/9nF7qZzNwcTQIahR8IYUYrwwoFA15gsT3oM6
   z1nD0n7MEfApTsSl8bEGW9HxQYawi1Ux9DrDxr2BAmFGw0Q/Y9LoRWASR
   fDO/ncvok8sOYY4NNF93vU/xIdqwbFbmO7DfMrbYI9+NjfZiwSnRleV/6
   o6Jh32lu10seFUsMHs62j08bpk5iU6s5Wei2bK9iJBuK54AjXtVBqnSnw
   LdBzPjTunw8+8waz7s8aY4iVYNTC2+ZACWd+O7LZa5S39n8lNgKq+NGTF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="25639526"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="25639526"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 12:11:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="29632546"
Received: from rfredric-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.amr.corp.intel.com) ([10.213.171.152])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 12:11:51 -0800
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: rex.zhang@intel.com,
	andre.glover@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH 0/2] crypto: Intel Analytics Accelerator (IAA) bugfixes
Date: Sun, 25 Feb 2024 14:11:32 -0600
Message-Id: <20240225201134.759335-1-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Herbert,

Here are a couple of bugfixes for some minor problems discovered while
testing.

Thanks,

Tom

Tom Zanussi (2):
  crypto: iaa - Fix async_disable descriptor leak
  crypto: iaa - Fix comp/decomp delay statistics

 drivers/crypto/intel/iaa/iaa_crypto_main.c  | 13 ++++++++--
 drivers/crypto/intel/iaa/iaa_crypto_stats.c | 28 ---------------------
 drivers/crypto/intel/iaa/iaa_crypto_stats.h |  8 +++---
 3 files changed, 15 insertions(+), 34 deletions(-)

-- 
2.34.1


