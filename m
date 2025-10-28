Return-Path: <dmaengine+bounces-7025-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027C8C16D22
	for <lists+dmaengine@lfdr.de>; Tue, 28 Oct 2025 21:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B06E5404305
	for <lists+dmaengine@lfdr.de>; Tue, 28 Oct 2025 20:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FC83081CB;
	Tue, 28 Oct 2025 20:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h/+yNDEm"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013048.outbound.protection.outlook.com [40.107.159.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B31C2BE058;
	Tue, 28 Oct 2025 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761684637; cv=fail; b=f8tw+ptosbSsb+vvGnW6p8X1XuEenKJQQl+nCnS9OAJnZKDEBrc4CeQ96gAW7lmK9Bu01BKlEuL70PDwCPs6mPnhVeqbAhK8fXBSi2qUgoMvbTNGDpSbgSQUwhbKBuGIfP9CrnW1JjSE5kdNNSULk0SH8RmjJtN79uiDTxXdqLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761684637; c=relaxed/simple;
	bh=RzHJ1Jse3LVJ+tEzyGXsBQ9tYp1CH0OS7lAqb5dBVeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O9jcDLXt2H3pOyA81k7FkCxtxvsxkk5xMDibHZPkHf3qoO47Z2WeOA+jvuTTMD1lq+J/+jaTpqiqb77r7dRC90lcRoM2Cqgo3iuU+ahqjgVy22eBlVgKM7sNLUMyAN6Rq3dqUxO+OjpSEcIvDH8SnGzZ6skFmIz/SuaQlQotvCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h/+yNDEm; arc=fail smtp.client-ip=40.107.159.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scVd6o+jUwP8BmdJBa6yTQS3znLAuCuOg98WzZSDHQ8tjfIXg5EHsx0v/ZkCBcPvKLcOWACVEs3AgoLcK2XnCNo8eGZl+l7GGNn/wzQp6/iYHrIFrfjlOrWQp43VIIozrpshxmr/cSwDvUMLu5on3BZ1l/ZOZBpFTpXrm45HM2JBV74dMJV5MvXOxt/u614fMvLqM7xl0+TgiZRUbxvXaGIkZNevHuzPstZ/tUHB3nUSN8AwR0Br5XXCcSIUoNLS4fvaLYnnGD+gV9s220LZBplqSxafvACBNyA7sHeECr8wW+vTSPya1NWGcGLAbzckmVCqPgHo5Z7wkBqtirR67Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJpeaYiNp1RXcYVzny2EOCqmuld8J7d4LJD5FoT2oEY=;
 b=ZX8qOLs+B4LNG8mEvSLI6rcBWaKUbRVlfYRzFFlwy7yaOBo8NqDqQrgwZqYqEQ7EjGdoIJkvjJoSZeRgijcR43xbBQ/M1rJL7YlMsl7ma3In3YYpit+p7yqJ2pgbeR0fTM0rHO4OroHtd3Kq38zSGVDItDJM1dz8h0ftl4fOWdsaLP4OpYjWEedvjoPRvuhPXDu++JOnwsHb1ODFYde/iyYp/hw8w5YoPjuzf7aKigJdAU0xgzl1MdsMNjxhDXjM47KFw08dUv2aklhlEhud5Kn65hQWcGFoFFscVOiY6HlSkVcfumzCYzPaQi0YpWQXDqNiUZXhFFKMwvWA4yP8yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJpeaYiNp1RXcYVzny2EOCqmuld8J7d4LJD5FoT2oEY=;
 b=h/+yNDEmUU6sd5ACgll+JOXsZIh5WOKyf5LJImyiMj9VeDOl6Z1o2bxvHrdNxq1o0nci9w2pY+DUmSF+QtwmEt2lC4lMQJjrrXQNA8stMqcCZ9cjSEtFvEZVlmBbrYRsUx+1aX5VYQ9tHytkCTeX0bB3iuN4ErF7xJQSVNOT3ZB2Ib+xFmYpUv0kr8sW+R+A5dstskYgUq0qsyRQRqGQyub9i34dCdd0+t1ifjsd8tRGG0AnrBndJt4kwGm+SCmPv48Xz6KB+OpxBb7oBmxP/xRwa0PLuxsuuQoMyuojI2XzyGiN1tVb9gXmfUwNLs3D/TI9x3ZFdMFDdGWXYZGqHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM9PR04MB8290.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 20:50:29 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 20:50:29 +0000
Date: Tue, 28 Oct 2025 16:50:18 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, corbet@lwn.net, vkoul@kernel.org,
	jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com, logang@deltatee.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org,
	jbrunet@baylibre.com, fancer.lancer@gmail.com, arnd@arndb.de,
	pstanner@redhat.com, elfring@users.sourceforge.net
Subject: Re: [RFC PATCH 00/25] NTB/PCI: Add DW eDMA intr fallback and BAR MW
 offsets
Message-ID: <aQEsip3TsPn4LJY9@lizhi-Precision-Tower-5810>
References: <20251023071916.901355-1-den@valinux.co.jp>
 <aPryDenvU7VTYpBp@lizhi-Precision-Tower-5810>
 <p6a5rfawgs3vcycm6ku23jpx4nhtmbuououfyfsypqli5t6zin@lekmytllocmc>
 <aPusw9M5kRA8G6NC@lizhi-Precision-Tower-5810>
 <igcadmsutjrert76iwfjhn7hg5j23z5blccxltwyuotbeislz4@3ze2av7sa32b>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <igcadmsutjrert76iwfjhn7hg5j23z5blccxltwyuotbeislz4@3ze2av7sa32b>
X-ClientProxiedBy: SJ0PR05CA0206.namprd05.prod.outlook.com
 (2603:10b6:a03:330::31) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM9PR04MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: 847cab5d-dd8e-45da-ff30-08de1663a0f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1dlMlpXTlRjbkdyckd5T0N2TXpMQ0JlRjhtYm9zZTNuMmJvM3pkekxlRzF3?=
 =?utf-8?B?TlpiRjhlZGEvR2dFVzY1WElsRlZFL3NyVFM1MVR0KzQ3eGhVN29DcWF5WXNx?=
 =?utf-8?B?T2RlcWdUSWUrbDZCZ0hsZC9va2dXaGdyRU5LeEJabHVPalVUSDdaR3EzNmRN?=
 =?utf-8?B?YkJsTmEySzh6dHZzNUZuMStBK3owNlpqcGtnNmsxbkd5cFYzUU41M3FsRm9s?=
 =?utf-8?B?Yko3VVNSTGRSSWd1VUZucUFHNlVjNVpzM2JWSHpDYy9kZkRlTkhKQmNKL0JF?=
 =?utf-8?B?SFoxcDRiSVBWa2U5NW5BZiszbitXZkhDaWUyQ1Uvb3plUjJON1VyZTNCSlAr?=
 =?utf-8?B?Um1nNllxbkl6MkVaYUlCbE4yRno5RDJmWEJBNlJzRkFFSzdjbmJHODZHSWpY?=
 =?utf-8?B?eHgrRE5uc3Qzdm1UMDZHV0NwNGFTSUhYM2IwcmZheWYzaytRYVM1MXZRaGFn?=
 =?utf-8?B?cEdxa2hNNVJqaFNYTElCSUtQY094dGNhU3ZFdzJUamFFMkErbGpQYXRpaE5M?=
 =?utf-8?B?RUlXMnU4OVR5dDRHU0JDNE0zb2EyVlFjRFZKMm5MOVdqRFRRWElCNG8ydkNU?=
 =?utf-8?B?aXhNeWlOYURRcGd3V1FWTlpKRjFkSEdCbS9WZDhxRmRBdC8wUUdsY1MzeFJx?=
 =?utf-8?B?R0hPaEhKTjR0TnN5TERMc3RZY3FMM1Vidk95ZHA3U1FiVzl3SFoxYSt0Y09C?=
 =?utf-8?B?TzA0NlBWWnlxaEJmektEbitRTDhXYWdFMHV5SHNKSFV6QWZKczJtRVF0WlhM?=
 =?utf-8?B?U3AxV1lkMEo3UDlVVHFNSXRvanFyWC9CT1BhOHlLbDI2M1h6a3hBOW43bmdN?=
 =?utf-8?B?N3M3bXlxN3pUNSs5RlMycTFOYmd4L05POTErVmVnbGFkUlczZW13WmNOWWR3?=
 =?utf-8?B?L1dIN2sranFoVzAzSERiSnhEcGYyVzB6VXBYNEVtWWEvQ3k1dXlrU3ZjSTE4?=
 =?utf-8?B?K2VwME8wV1ZqWWxKL2tDWlJ4VXVsZXBvT2JtZDVoU256QjR2MWZNMVZGdHdJ?=
 =?utf-8?B?T25sSDlCZzE4WU4vb0pnTEJqYndRU3FsUUV5dmRTd0l6Nzh2bjZxMWhMbVNu?=
 =?utf-8?B?dUFZNDRTbDlFUHJLMjI5bGlTNEZvcGJSeHVnNm43Y1lsZ05hRU9UWGxlbjZ6?=
 =?utf-8?B?NHJ2Zlc0Ti9tOFRhdzZHL2kxVm4vR3pkY2cvRTRtaUxXTEljaVhEcmJWWkN2?=
 =?utf-8?B?bGx2T2cyem5YeW9iY0JEbzdqUGR4OHBJZnBtV1pZajc4YUtoOWhoeHUrbXNS?=
 =?utf-8?B?SHlZWXlRRTRYZUpaaWczVmg4RFVXVWtEMzdLcEVHcjYydUV3ZStkcFNpQi9p?=
 =?utf-8?B?cG9hejlsd3A4d3pPOG5zU2xyZEUvYk53ek02a213RnBidm9vNXllMG9Qa0Qv?=
 =?utf-8?B?SDdPS1hTeVY2WWI2STZOUStJVE0xVmFDWHlUZ2c1czVCb0RNNHhkVUd3ajMr?=
 =?utf-8?B?M090c09SY3ZXZE5RZUJZbUh1d1JzeUVqM3ZvNVVPY2pLRlEzRHV3S25nOXpz?=
 =?utf-8?B?ZDRjclNnbmdqc3RlTUZIWVJXZ2pFcW5XRm5wUmZpbWx1K1E0NTI1anV1QXJ5?=
 =?utf-8?B?OW5xRWg4QlNGZTBTYUQvSno0UWRNajJoQWhaOFZ4TkVzRVVnMGFMMkZyb2w5?=
 =?utf-8?B?Wno1eTl1cWp6cm5nM3JmZk1hUmtCWFZoTElTMFAycTdZY1RjMGRoL21ibzJ2?=
 =?utf-8?B?SUdmL2h4NHFEdUtBU1U2QUxaRUdid2s1RkFWRUd5OS9tSDhrY0ZEWEpoN01J?=
 =?utf-8?B?Y1ZrTSt2NEtuSjRpZWlZdFBBeFhiVmVIZ2FRbGtFNml6VFo0R2RhSFFTR01M?=
 =?utf-8?B?QWUwOWNOVm13STVzSGV5dUNvNDBqTGF6WE05WFVMOFp6ZFp6QmtheTd0NzFo?=
 =?utf-8?B?RDFSQ08zdXNwQVoweXMwb0M0R0lqZDZoVDJ6aWRkWjhIRGtNekdTVmlCYi94?=
 =?utf-8?B?YTYrS1pYSStHeTQzcTEydVVMcGJGampLQjBOQlUvazVtL3NBbVhuM0tOOHpB?=
 =?utf-8?B?Wk5BVUhRVkRUN2NwaHN3YTZid2ZjdnkxeXEzOHU2MTI0RzROQ1hjbkE5cVpi?=
 =?utf-8?Q?4aMeab?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzY2dW9RK0RzU0VEZnVDSmMvOXpPVU1kSk0ra0F5RVFRYlBQUFpaelV4cnJT?=
 =?utf-8?B?UGRRbFAxRFBSaStTZWlzYzVldEZ3MUYwU2N1NDNJa0oreHkvK3o0aGdFVlU4?=
 =?utf-8?B?WEJucXhjUkV1Q0lUUnMrMmEweTc5OCtmZmcyVUF5dml4TE5PclZmWkVMMk1t?=
 =?utf-8?B?elRITTJLN29BOThQSE02S0REUjAvUW1mL2RuTHIvZG04RGhSVUZqaE5EbWZi?=
 =?utf-8?B?MDR0ZkVIQWRab2VELy9ocEdvNWpwejJLMFBQNzZ2dU1hamt6MWtPMmMrbTB4?=
 =?utf-8?B?VlJwQy91cFNXdlFTWFVmeGVVMXhOVnh2b2gvZmpMKzNEdFNsemJ3aFE3NExU?=
 =?utf-8?B?TTgveXdlZUdpUTlNSFJ2WGdiVkFBVEhpUGRqdEZCaGx1QUMzU1puTVF3eVcy?=
 =?utf-8?B?VnBVRWNXZXBoeHozaHJ3Sy8yR3JpNzc0eGl2VGZaUGUzWFlrcXJ4cmdMYURL?=
 =?utf-8?B?STZDOXIwSndsUWl2dEhreTZPck52bjBjZHJkSmNUZTkrSUZSdXh6SVVDRHVN?=
 =?utf-8?B?VnFPcHNoYWViYTQ5bFpVaDNHUW90ckNNRHNxZ1N6YndCaUpqSDdVclVoNFd6?=
 =?utf-8?B?V1FHamJqL0xDVTE0VDVvMG9VanZwK1hsNlVCZFUwSFI5eGp0R2t3cURCMDZt?=
 =?utf-8?B?QnRwQlVOSzV3a2JHSXZVVmk3TUU0N2o0ZjZiTGRvZzJ2NDUyMzMzNVFHbzJh?=
 =?utf-8?B?TThRWkxISy9LWnNuNUU2UnBDblJPM0JsREtSSmxhR0lUVTVOSU5jajdyVTQ3?=
 =?utf-8?B?eFkxK1JVRFMybG9xSHlNaGMyVnUzWTRjOGNqazFyaE9udzZlU3YxT0g5MVRz?=
 =?utf-8?B?MGhYeTJlMUVKc2tIUlRxMVZZZVdCc0w3ZGEwZkdjdDA4WXJRNkcvTjQyTGNj?=
 =?utf-8?B?RGkrckVjaHVlK1Y5V3kwai9rZ0hITXV2d21ZWC8zbjUxcGZYL3g0VGpzT2ZU?=
 =?utf-8?B?VmFPUUQ5aXAvWExmbW1PR0ZwM0hoZGdmVFJzNXBZc1FEVEg2QXhOcDA3ME82?=
 =?utf-8?B?NHNVRy8vRGdSRkI2bXNSem0wTVcxTi9jRWRTb1B2RndUcS8vSDJoZ2hNR0FD?=
 =?utf-8?B?OVpOUGRoL2JSclh6V2FpaTBhWWYzRU1UVUxkOG92MlJVblZzWXdyTkdZbHBQ?=
 =?utf-8?B?WnBablBGelZDcFZrN3JtQ1JFUmlpZ2VjNUl0VVFJd0FzeWo1YWh6S1QyOWZi?=
 =?utf-8?B?NCszSFl5OFhNYnNqckd1d2xBUEVjV2M4clRkR2ltMXlDU0hDZkNrTFdxUjdL?=
 =?utf-8?B?ekR5aFBNeXp6VXNpSUtCVzdvM2J1OWl0MmdnVjlnb0pzUDlCOXBtUVQ5algy?=
 =?utf-8?B?bnhXcTN0TUdLMVZtOWJ3ekVlZkxid2E3NDJ5a1lXN1ozOG1nL3REdFR5Rk1O?=
 =?utf-8?B?Ykc4WktVYzNLTGVCQTIrS1RYM0hDUDJ0dzZ2NlZ3bzdrZVUwL3d4TWlWeS9D?=
 =?utf-8?B?eVNiQW5ucDB3cS9NY0dzRWJKYTgvNG9tMEhWQTczS1lPbzk1am1NYUVjRjRR?=
 =?utf-8?B?Ylk1enNtSVRlR1NzK0t4bk9HWUg1MDMyckhDMjdEbkJIRThTRHozTGJCZnY0?=
 =?utf-8?B?RjJrZUhZTGEyWExCRTBCZjg5c2Q5S0hvNDIxOS9JY0NyZlF2bmd5RHpSSUdw?=
 =?utf-8?B?L3djSGVidUUybG1IdzN4d1BSYzJSMkJOUHdnVm93UEhOeWV0SUk2Y3o2WVdv?=
 =?utf-8?B?UkNPQW8yZzNYWmpwVFIvL25UZk1JMENlS09LeUd4MnM5MDJsSkp3N08vaFV6?=
 =?utf-8?B?bFNoajV0TzR5M0pEdzk0emdxejdnZ2NBUXM3dTlWSVZmN1U4S1oxcEdWdXA5?=
 =?utf-8?B?UFdJMjBHZG4wSEZZRkcrYXNya2x1UWthU1MvTmdPYisyeVJBNVFhS2N5VUtl?=
 =?utf-8?B?MlZicFBiN1NWcFdPajNYWHpQWi81WTBMRE45U2hYOWVQMDY1UW51MVhTdnE3?=
 =?utf-8?B?N3BLd2Z3cWhPbEkwMW9uRFpDRG5ibGk1WndOdjQ1azFKY3pYSWFsWWh0OE1V?=
 =?utf-8?B?ZmFMVklzQ2NQSDhLNnIvZzhEUlpoN1h1T1NJWVdEeHQwVjI2N3BGQVp5V0I0?=
 =?utf-8?B?Vk5zeUtBbXVkSjNDcUtFM3RkMkZhLzZoWWFuSnYzempQcE1NM0FTZ2FxbkpM?=
 =?utf-8?Q?6Z8A=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 847cab5d-dd8e-45da-ff30-08de1663a0f6
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 20:50:29.2786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+GVwWr8UsnuE70QCBOjcKbVZJUNeBoqU7aq5Dkiv3nlULRl7eTzlZImk4PopJT/U5VZAlptvP5fX8OPnljSow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8290

On Mon, Oct 27, 2025 at 02:29:30PM +0900, Koichiro Den wrote:
> On Fri, Oct 24, 2025 at 12:43:47PM -0400, Frank Li wrote:
> > On Sat, Oct 25, 2025 at 01:04:01AM +0900, Koichiro Den wrote:
> > > On Thu, Oct 23, 2025 at 11:27:09PM -0400, Frank Li wrote:
> > > > On Thu, Oct 23, 2025 at 04:18:51PM +0900, Koichiro Den wrote:
> > > > > Hi all,
> > > > >
> > > > > Motivation
> > > > > ==========
> > > > >
> > > > > On Renesas R-Car S4 the PCIe Endpoint is DesignWare-based and the platform
> > > > > does not allow mapping GITS_TRANSLATER as an inbound iATU target. As a
> > > > > result, forwarding MSI writes from the Root Complex (RC) to the Endpoint
> > > > > (EP) is not possible even if we would add implementation to create a MSI
> > > > > domain for the vNTB device to use existing drivers/ntb/msi.c, and NTB
> > > > > traffic must fall back to doorbells (polling). In addition, BAR resources
> > > > > are scarce, which makes it difficult to dedicate a BAR solely to an
> > > > > NTB/msi window.
> > > > >
> > > > > This RFC introduces a generic interrupt backend for NTB. The existing MSI
> > > > > path is converted to a backend, and a new DW eDMA test-interrupt backend
> > > > > provides an RC-to-EP interrupt fallback when MSI cannot be used. In
> > > > > parallel, EPC/DWC gains inbound subrange mapping so multiple NTB memory
> > > > > windows (MWs) can share a single BAR at arbitrary offsets (via mwN_offset).
> > > > > The vNTB EPF and ntb_transport are taught about offsets.
> > > >
> > > > Map multi address to one bar is quite valuable, so we can start it as the
> > > > first steps.
> > > >
> > > > But I have a problem about DWC iATU address map mode. for example, bar0
> > > > to cpu address 0x8000000 (Local CPU).  but difference RC system, at RC side
> > > > bar0 address is variable. May be 0xa000_0000 (RC side), maybe 0xc000_0000
> > > > (RC side).
> > > >
> > > > Set bar0 mapping before linkup.
> > > >
> > > > How do you know PCI bus address is 0xa0000000 or 0xc0000000.
> > >
> > > Thanks for the comment.
> > >
> > > For vNTB this is done in two steps:
> > >
> > > 1). In the epf_ntb_bind() path we call pci_epc_map_inbound() with
> > >     epf_bar->phys_addr == 0. On the DWC side this only triggers
> > >     dw_pcie_ep_set_bar_init() and does not program an inbound iATU yet.
> > >     (pls see Patch #5).
> > > 2). Later, when ntb_transport's link work runs and we actually need to
> > >     set up Address Match inbound window(s), pci_epc_map_inbound() is called
> > >     again with epf_bar->phys_addr != 0 (and an offset for the sub‑range). At
> > >     that point the RC has already enumerated the device and assigned the BAR,
> > >     so dw_pcie_ep_map_inbound() reads back the assigned BAR value via
> > >     dw_pcie_ep_read_bar_assigned(), computes pci_addr = base + offset, and
> > >     programs the inbound iATU in Address Match mode (again, Patch #5 is
> > >     relevant).
> > >
> > > Because we do not program the inbound iATU before enumeration, we don't
> > > need to know upfront whether the RC will place BAR0 at 0xa000_0000 or
> > > 0xc000_0000. We read the assigned address right before the actual
> > > programming (again, see the Patch #5). Am I missing something?
> >
> > This should work for vntb user case. It needs generalize for other usage
> > mode. maybe combine multi regions to one bar.
>
> IMO it's already generized infrastructure. I'm not sure if we need to
> retrofit other EPFs (pci_epc_set_bar callers) in this series. We can do
> that when there's really a concrete need.
>
> >
> > Add a case in pci-ep-test function drivers to let more people can review
> > it.
>
> This sounds reasonable, though it may involve seemingly a bit of duplicate
> work, i.e. adding a similar configfs knobs on the pci-epf-test side, expand
> the control register fields, make pci_endpoint_test aware of it, and
> makeing sure that the selftest still pass. Please correct me if I'm off
> here. I'll take some time to prepare that.
>
> Thanks for the review.

I like combine eDMA address to one bar, so RC side ntb epf driver can use
dw-edma driver, (suppose just refer drivers/dma/dw-edma/dw-edma-pcie.c)
to register a host side dma engine, so ntb transfer can use this dma
engineer to do data transfer (with little bit modify to support periphal
mode).

So data transfer speed can get big improvement.  Of source also use eDMA
as doorbell work if there are enough dma channels in dwc controller.

Frank

>
> -Koichiro
>
> >
> > Frank
> >
> > >
> > > -Koichiro
> > >
> > > >
> > > > Frank
> > > >
> > > > >
> > > > > Backend selection is automatic: if MSI is available we use the MSI backend.
> > > > > Otherwise, if enabled, the DW eDMA backend is used. If neither is
> > > > > available, we continue to use doorbells. Existing systems remain unaffected
> > > > > unless use_intr=1 is set.
> > > > >
> > > > > Example layout (R-Car S4):
> > > > >
> > > > >   BAR0: Config/Spad
> > > > >   BAR2 [0x00000-0xF0000]: MW1 (data)
> > > > >   BAR2 [0xF0000-0xF8000]: MW2 (interrupts)
> > > > >   BAR4: Doorbell
> > > > >
> > > > >   # The corresponding configfs settings (see Patch #25):
> > > > >   echo 0xF0000 > ./mw1
> > > > >   echo 0x8000  > ./mw2
> > > > >   echo 0xF0000 > ./mw2_offset
> > > > >   echo 2       > ./mw1_bar
> > > > >   echo 2       > ./mw2_bar
> > > > >
> > > > > Summary of changes
> > > > > ==================
> > > > >
> > > > > * NTB core/transport
> > > > >   - Introduce struct ntb_intr_backend and convert MSI to the new backend.
> > > > >   - Add DW eDMA interrupt backend (CONFIG_NTB_DW_EDMA) as MSI-less fallback.
> > > > >   - Rename module parameter to use_intr (keep use_msi as deprecated alias).
> > > > >   - Support offsetted partial MWs in ntb_transport.
> > > > >   - Hardening for peer-reported interrupt values and minor cleanups.
> > > > >
> > > > > * PCI Endpoint core and DWC EP controller
> > > > >   - Add EPC ops map_inbound()/unmap_inbound() for BAR subrange mapping.
> > > > >   - Implement inbound mapping for DesignWare EP (Address Match mode), with
> > > > >     tracking of multiple inbound iATU entries per BAR and proper teardown.
> > > > >
> > > > > * EPF vNTB
> > > > >   - Add mwN_offset configfs attributes and propagate offsets to inbound maps.
> > > > >   - Prefer pci_epc_map_inbound() when supported. Otherwise fall back to
> > > > >     set_bar().
> > > > >   - Provide .get_pci_epc() so backends can locate the common eDMA instance.
> > > > >
> > > > > * DW eDMA
> > > > >   - Add self-interrupt registration and expose test-IRQ register offsets.
> > > > >   - Provide dw_edma_find_by_child().
> > > > >
> > > > > * Renesas R-Car
> > > > >   - Place MW2 in BAR2 to host the interrupt window alongside the data MW.
> > > > >
> > > > > * Documentation
> > > > >
> > > > > Patch layout
> > > > > ============
> > > > >
> > > > > * Patches 01-11 : BAR subrange and MW offsets (EPC/DWC EP, vNTB, core helpers)
> > > > > * Patches 12-14 : Interrupt handling hardening in ntb_transport/MSI
> > > > > * Patches 15-17 : DW eDMA: self-IRQ API, offsets, lookup helper
> > > > > * Patches 18-19 : NTB/EPF glue (.get_pci_epc())
> > > > > * Patch 20      : Module param name change (use_msi->use_intr, alias preserved)
> > > > > * Patches 21-23 : Generic interrupt backend + MSI conversion + DW eDMA backend
> > > > > * Patch 24      : R-Car: add MW2 in BAR2 for interrupts
> > > > > * Patch 25      : Documentation updates
> > > > >
> > > > > Tested on
> > > > > =========
> > > > >
> > > > > * Renesas R-Car S4 Spider
> > > > > * Kernel base: commit 68113d260674 ("NTB/msi: Remove unused functions") (ntb-driver-core/ntb-next)
> > > > >
> > > > > Performance measurement
> > > > > =======================
> > > > >
> > > > > Even without the DMA acceleration patches for R-Car S4 (which I keep
> > > > > separate from this RFC patch series), enabling RC-to-EP interrupts
> > > > > dramatically improves NTB latency on R-Car S4:
> > > > >
> > > > > * Before this patch series (NB. use_msi doesn't work on R-Car S4)
> > > > >
> > > > >   # Server: sockperf server -i 0.0.0.0
> > > > >   # Client: sockperf ping-pong -i $SERVER_IP
> > > > >   ========= Printing statistics for Server No: 0
> > > > >   [Valid Duration] RunTime=0.540 sec; SentMessages=45; ReceivedMessages=45
> > > > >   ====> avg-latency=5995.680 (std-dev=70.258, mean-ad=57.478, median-ad=85.978,\
> > > > >         siqr=59.698, cv=0.012, std-error=10.473, 99.0% ci=[5968.702, 6022.658])
> > > > >   # dropped messages = 0; # duplicated messages = 0; # out-of-order messages = 0
> > > > >   Summary: Latency is 5995.680 usec
> > > > >   Total 45 observations; each percentile contains 0.45 observations
> > > > >   ---> <MAX> observation = 6121.137
> > > > >   ---> percentile 99.999 = 6121.137
> > > > >   ---> percentile 99.990 = 6121.137
> > > > >   ---> percentile 99.900 = 6121.137
> > > > >   ---> percentile 99.000 = 6121.137
> > > > >   ---> percentile 90.000 = 6099.178
> > > > >   ---> percentile 75.000 = 6054.418
> > > > >   ---> percentile 50.000 = 5993.040
> > > > >   ---> percentile 25.000 = 5935.021
> > > > >   ---> <MIN> observation = 5883.362
> > > > >
> > > > > * With this series (use_intr=1)
> > > > >
> > > > >   # Server: sockperf server -i 0.0.0.0
> > > > >   # Client: sockperf ping-pong -i $SERVER_IP
> > > > >   ========= Printing statistics for Server No: 0
> > > > >   [Valid Duration] RunTime=0.550 sec; SentMessages=2145; ReceivedMessages=2145
> > > > >   ====> avg-latency=127.677 (std-dev=21.719, mean-ad=11.759, median-ad=3.779,\
> > > > >         siqr=2.699, cv=0.170, std-error=0.469, 99.0% ci=[126.469, 128.885])
> > > > >   # dropped messages = 0; # duplicated messages = 0; # out-of-order messages = 0
> > > > >   Summary: Latency is 127.677 usec
> > > > >   Total 2145 observations; each percentile contains 21.45 observations
> > > > >   ---> <MAX> observation =  446.691
> > > > >   ---> percentile 99.999 =  446.691
> > > > >   ---> percentile 99.990 =  446.691
> > > > >   ---> percentile 99.900 =  291.234
> > > > >   ---> percentile 99.000 =  221.515
> > > > >   ---> percentile 90.000 =  149.277
> > > > >   ---> percentile 75.000 =  124.497
> > > > >   ---> percentile 50.000 =  121.137
> > > > >   ---> percentile 25.000 =  119.037
> > > > >   ---> <MIN> observation =  113.637
> > > > >
> > > > > Feedback welcome on both the approach and the splitting/routing preference.
> > > > >
> > > > > (The series spans NTB, PCI EP/DWC and dmaengine/dw-edma. I'm happy to split
> > > > > later if preferred.)
> > > > >
> > > > > Thanks for reviewing.
> > > > >
> > > > >
> > > > > Koichiro Den (25):
> > > > >   PCI: endpoint: pci-epf-vntb: Use array_index_nospec() on mws_size[]
> > > > >     access
> > > > >   PCI: endpoint: pci-epf-vntb: Add mwN_offset configfs attributes
> > > > >   NTB: epf: Handle mwN_offset for inbound MW regions
> > > > >   PCI: endpoint: Add inbound mapping ops to EPC core
> > > > >   PCI: dwc: ep: Implement EPC inbound mapping support
> > > > >   PCI: endpoint: pci-epf-vntb: Use pci_epc_map_inbound() for MW mapping
> > > > >   NTB: Add offset parameter to MW translation APIs
> > > > >   PCI: endpoint: pci-epf-vntb: Propagate MW offset from configfs when
> > > > >     present
> > > > >   NTB: ntb_transport: Support offsetted partial memory windows
> > > > >   NTB/msi: Support offsetted partial memory window for MSI
> > > > >   NTB/msi: Do not force MW to its maximum possible size
> > > > >   NTB: ntb_transport: Stricter checks for peer-reported interrupt values
> > > > >   NTB/msi: Skip mw_set_trans() if already configured
> > > > >   NTB/msi: Add a inner loop for PCI-MSI cases
> > > > >   dmaengine: dw-edma: Add self-interrupt registration API
> > > > >   dmaengine: dw-edma: Expose self-IRQ register offsets
> > > > >   dmaengine: dw-edma: Add dw_edma_find_by_child() helper
> > > > >   NTB: core: Add .get_pci_epc() to ntb_dev_ops
> > > > >   NTB: epf: vntb: Implement .get_pci_epc() callback
> > > > >   NTB: ntb_transport: Rename use_msi to use_intr (keep alias)
> > > > >   NTB: Introduce generic interrupt backend abstraction and convert MSI
> > > > >   NTB: ntb_transport: Rename MSI symbols to generic interrupt form
> > > > >   NTB: intr_dw_edma: Add DW eDMA emulated interrupt backend
> > > > >   NTB: epf: Add MW2 for interrupt use on Renesas R-Car
> > > > >   Documentation: PCI: endpoint: pci-epf-vntb: Update and add mwN_offset
> > > > >     usage
> > > > >
> > > > >  Documentation/PCI/endpoint/pci-vntb-howto.rst |  16 +-
> > > > >  drivers/dma/dw-edma/dw-edma-core.c            | 109 ++++++++
> > > > >  drivers/dma/dw-edma/dw-edma-core.h            |  18 ++
> > > > >  drivers/dma/dw-edma/dw-edma-v0-core.c         |  15 ++
> > > > >  drivers/ntb/Kconfig                           |  15 ++
> > > > >  drivers/ntb/Makefile                          |   6 +-
> > > > >  drivers/ntb/hw/amd/ntb_hw_amd.c               |   6 +-
> > > > >  drivers/ntb/hw/epf/ntb_hw_epf.c               |  46 ++--
> > > > >  drivers/ntb/hw/idt/ntb_hw_idt.c               |   3 +-
> > > > >  drivers/ntb/hw/intel/ntb_hw_gen1.c            |   6 +-
> > > > >  drivers/ntb/hw/intel/ntb_hw_gen1.h            |   2 +-
> > > > >  drivers/ntb/hw/intel/ntb_hw_gen3.c            |   3 +-
> > > > >  drivers/ntb/hw/intel/ntb_hw_gen4.c            |   6 +-
> > > > >  drivers/ntb/hw/mscc/ntb_hw_switchtec.c        |   6 +-
> > > > >  drivers/ntb/intr_common.c                     |  61 +++++
> > > > >  drivers/ntb/intr_dw_edma.c                    | 253 ++++++++++++++++++
> > > > >  drivers/ntb/msi.c                             | 186 +++++++------
> > > > >  drivers/ntb/ntb_transport.c                   | 155 ++++++-----
> > > > >  drivers/ntb/test/ntb_msi_test.c               |  26 +-
> > > > >  drivers/ntb/test/ntb_perf.c                   |   4 +-
> > > > >  drivers/ntb/test/ntb_tool.c                   |   6 +-
> > > > >  .../pci/controller/dwc/pcie-designware-ep.c   | 242 +++++++++++++++--
> > > > >  drivers/pci/controller/dwc/pcie-designware.c  |   1 +
> > > > >  drivers/pci/controller/dwc/pcie-designware.h  |   2 +
> > > > >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 197 ++++++++++++--
> > > > >  drivers/pci/endpoint/pci-epc-core.c           |  44 +++
> > > > >  include/linux/dma/edma.h                      |  31 +++
> > > > >  include/linux/ntb.h                           | 134 +++++++---
> > > > >  include/linux/pci-epc.h                       |  11 +
> > > > >  29 files changed, 1310 insertions(+), 300 deletions(-)
> > > > >  create mode 100644 drivers/ntb/intr_common.c
> > > > >  create mode 100644 drivers/ntb/intr_dw_edma.c
> > > > >
> > > > > --
> > > > > 2.48.1
> > > > >

