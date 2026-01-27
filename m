Return-Path: <dmaengine+bounces-8525-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOd2FSwzeGlRowEAu9opvQ
	(envelope-from <dmaengine+bounces-8525-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 04:38:20 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B26018FA6A
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 04:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC5803081157
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 03:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33A830BF64;
	Tue, 27 Jan 2026 03:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="MbfggSc+"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020110.outbound.protection.outlook.com [52.101.228.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A34030DEBB;
	Tue, 27 Jan 2026 03:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769484902; cv=fail; b=bw4cM/AFkzkWRXnv4/cmUlgqW5Ne2P5N2xGC6qYokG3UxZJHLgOGWcIS0iOdnUCa2TPYrMt6vc4b38iwuODupiO0X564e1T8Cb42maUcpe/u4s0pxGlgjyRdEh4TG1QO362a17o4AY5yX9VrfBF1TDqPJGwvWihnMTagI7KGnCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769484902; c=relaxed/simple;
	bh=X5h5KITbnLDUM5vZ0sjOVUR+jOI60EWRavInB5R7VHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FrYPnWD9ddWquL4Qs1rNrBBddAWq5Oc+n8LXt3We9hzWirDaqW6gb+eRDZHSiWzi2MQQduTL+TIHVv/9rtiQhvJKnq4fXfdJ5H76JK/LOGnoTNjqqZZLC1SVwaZ0gpYX6bgYaIpWXakoP3a8p8QVHwZZ2zpMUwon6QcLazNHWG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=MbfggSc+; arc=fail smtp.client-ip=52.101.228.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1wlu9kmlV/Lz+sV1zcgC3ZAXx4iKWlMOKGLLIRe3zDZeudwyg/R4JJSgTKYmGNny2EVjVrGOy1mRMZmM9dlnBz1bDKbp4kBjAr/B+Tz/nQj6PGHI66nsILukZAU4yctLFJ13uxUb5bKnQPIr2/LV+RveiD4XqRSce/Dk80zz9x/hwy/wAZdJ/Y9FQG5xRARLaRbVbk4Bk2sZ0Hvg/WIFhOIZisJZaZS2QkuV4HIlPn2SInHXbSUiEqzGs/MKIlcPW+f+nG67WxglkealIm3ywQWC5u9akbMjQE2bp/1UDQrAtSOSy2GHeWl9PC9ITLW4R+swK1eBVPbfJOnb6eLiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dn2+gl/ceTIgMuy3VSaoxy3zFwCS0PCmo1sp/rz5C5Y=;
 b=PzznaX7P5rQ3GHeaPmdoK1p+yilw/k3rfvUCuF42lRj5rAQaMLTNhrw+xFtffMuCYXkDaJAqZtXKkNdOYaV2hS+a7RCVeDt+z33iKE1syMUbsAbHakiCZhnGZ5rjWT+euZWUOhWEo7djjdRyDxDNonnoPPl5UOrr9twzhCgazNN6zZj5jxczTCqAl0qYDK3ZsfwM1Ngqck5+XIiaqjsD3uc/GW5MgNEbxPW0+lv4IVOsNogCzArLFf6x1wFMb7ES3hqNoj1OPKl9ty6PVQHtUYLyg3AQW6AVcIX4V6FtaMr73BZMIjj3TF/7X72ONyC5L2p0Wi00g6f49quYGoGLRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dn2+gl/ceTIgMuy3VSaoxy3zFwCS0PCmo1sp/rz5C5Y=;
 b=MbfggSc+NiSH+ahWo/mZixtfWgY7hBWkN0te47K35M0APXDQ0qCztXmy/WMvx63fXBKs7ga69M5GnxHA70AhPJX9usIu9RMKqcpQ9sh6bKQRcAg8N9mFYLWr1gVCX3wIRjZ1dHcDZlYvX8CWzYQgi/pYbCBgwBuGSpmdLEZWXgo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSCP286MB5626.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:3c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 03:34:46 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 03:34:46 +0000
From: Koichiro Den <den@valinux.co.jp>
To: vkoul@kernel.org,
	mani@kernel.org,
	Frank.Li@nxp.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com
Cc: dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] PCI: dwc: Add helper to query integrated dw-edma linked-list region
Date: Tue, 27 Jan 2026 12:34:20 +0900
Message-ID: <20260127033420.3460579-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127033420.3460579-1-den@valinux.co.jp>
References: <20260127033420.3460579-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0036.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::20) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSCP286MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: 33f60840-8b3f-4196-c671-08de5d5504c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5+72IdPKyI3pqYzxiwCYO/0cSg+Kb2j+aSDS0Z7xVYA0Zkmv0mBWgOLJ2Jr1?=
 =?us-ascii?Q?iOkb99KcVh3Fmo5C4XKVFu3W6FEZR6PV9tPuI0wasJ2mNpDpi5wVg4Og1EEO?=
 =?us-ascii?Q?P8YNN8WCwdTqaLCDQV3J+9K2C0uCs+xve04oPTfsWC7SRY1ABdLijorigy21?=
 =?us-ascii?Q?1aAValrnyH+jXUH0iU7ZtPpTx6JJA4DEyjep/oG2GyUN/lMvX9DY6YIalYbc?=
 =?us-ascii?Q?LJvvbh6rpjCipgZpeBjugSpzv0cP4vPFCZ1JauB6T0WtcPTNGGRhqmgxPC75?=
 =?us-ascii?Q?qlEcoLQiPZs0WBNN/TlLuFYpJUNpo/dflhmzxniKQFK8pTuvFWdm8wH4KymC?=
 =?us-ascii?Q?nkLkLu3P1CUpgeil9P68Vk8UrU3wNTCXGo4xdv9KG4kYX5CvG9j6gCFC3neQ?=
 =?us-ascii?Q?kvgL0cOzeZ3CNf30BBqrh2QLi2EI4MPS89WGriGlwgQrjXWh6VqKlHiXNz/P?=
 =?us-ascii?Q?DFkvJYtPpgMFdZrJh4sgygIe7qjDB0Lkd5xQuI5u4yuErXlRuEdH9RNWNUT9?=
 =?us-ascii?Q?bjAwxlhgQeNSizNz8ucUmvSh/C1B5NYvIVZdplHDvKSOxuF+NtFVc8bVLEZ5?=
 =?us-ascii?Q?xbgCznaSZeNoJexTvOWbiuLv6XSAuB0pOx3Iggy6ldsPoltGoaK3RA2SMVSw?=
 =?us-ascii?Q?QwRNQkMU4cwZErcDDyAsA0uk//R7ES5fFbwK3A7wRaJ7Q9ioiRUHqEaVrWGA?=
 =?us-ascii?Q?OH3/6FbjnwiLAwS3aVMkyWLwxDi8B7/WAoZ1Kv8E4fsx/3Zb6dgcDfYcq5BY?=
 =?us-ascii?Q?wakSYhPWpPBdguFq2KIRxpcf3OAgSOcD2YUGsaduC2JLe1EZNNAVvjBquSQX?=
 =?us-ascii?Q?gKgKkpHDVa/BZMm26CS9rRpWRCPgAYRR+fYL5ssKug+kYOV45mRCLCBWwzqu?=
 =?us-ascii?Q?ZjWkThqOQtH7MVXXXM1f4jmPkOvR9wRQIMH4FnZ58yLI9bwqhKBQgEQFwo5U?=
 =?us-ascii?Q?kQLpqilnO5tkYzYP1p+YlCDG0+P0+negyRZpJDujTBsE7DgvaB/x9k4FNxqi?=
 =?us-ascii?Q?CUMGQrLqDLYhM5s8LXnKEOHEi4XhvbUohxAiLajrtyexyvZacHdwOlUA09Bg?=
 =?us-ascii?Q?SwaxmK2L7kAODmxCf8FDHSHZPy/vweTizTwHbTXisekFQkqkiHviZ0ZO25Mf?=
 =?us-ascii?Q?DEvLfK/5vk6B9j6H+AS76Clz29/IfosO7773drjyfuIB40A4TBhmGu6C4gbh?=
 =?us-ascii?Q?486tzdCx+oAEQrXBA9Qbbi8Oo2oOde0PUyLGXg2lfGacmnnHI+HZXMHKmvif?=
 =?us-ascii?Q?ZSoF2Uub8vg13ndLch/WOR5+LyRdbbrcnQRXh6RDw7NFjz5JntAV3+xc+VtB?=
 =?us-ascii?Q?VbYm3DSTXciPOBYgXzD7Kywht1AqyCshPyCj2zpmq8I5UG6V0xO9NV9hnBFk?=
 =?us-ascii?Q?OBcpD+vCOsKgP+lG0VOujMRf5HaNODhH36dnEMG6gGGyRA5eutZs1oEQ4SGR?=
 =?us-ascii?Q?jP4DCVfcqgIHzoNQiTcZupJO9xR88Vz/xhjaMZFuQELAUKCV0UTxtgHyxxaA?=
 =?us-ascii?Q?oono9wjtxjd0dX732ec6LrHwB2XZN50yC5/cTfeE7vgHEnLhU+055JgQdDVA?=
 =?us-ascii?Q?oV8qALSp6gVbvDEqKaA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wBVtJMUCO3YUlevdSF0vLyf0Pc15A5nyBKz9WfWCiKgOKc4wdjlughK41krc?=
 =?us-ascii?Q?RkOfnBRnimunFneoz5jizSKGXH5+y0v3tiXn4+ybUx6TT/7Tr782UepUOFK7?=
 =?us-ascii?Q?t1xoVdwIounzP3PejvrG53YIuA6MM4iPwf2U2mzRxMyaWpr4u/zddpuXyZd9?=
 =?us-ascii?Q?LLeMvk9ghRZ27JqvGRZBSdn9AB0LRaEZ7UohVqGoF6p8CWcl1ZhC9I3+iqEU?=
 =?us-ascii?Q?mp2/oE/glHsPemHOLxnkNJSzWPKMqPPCx28HDGu+kE3Lm48OzAQmgKekvO9Y?=
 =?us-ascii?Q?mMskhVzY7dMAvwBWcqgf69NvGEbXELi4SiyYu7nwqqC1aAqlx1+1lrBxI6o1?=
 =?us-ascii?Q?5ZJqlvi7m7izGbead0gFUvXAoe5AV6ZUW2zDKYxcS7wLmcjW44a6g50wnsPS?=
 =?us-ascii?Q?tsMD9rXzG3xiSu7DW+2xKSplEPxdaUzP1XlRt5huKqKa5MFRxhckKSwkeYUg?=
 =?us-ascii?Q?fdOMukPQe9b3+Chi47fe9tjMZ6ycd3S8nw8ZKUwFGlLrxu07wjdZHR7dKE6L?=
 =?us-ascii?Q?ZgHkihxXvSvPOLCQyp80WPu+CJgaKzy8GNfS59Y7DJn470QjcT6lyolDWDLc?=
 =?us-ascii?Q?EIG6d4jz4pNvIN1Ur9rh4k89xeafZXlZO9BO2kJNQ8K/7sqCcavwEtavv+yL?=
 =?us-ascii?Q?lLiHw+Sp/Rbhqoif16FyJFowPwKJvac7WKscs7Pn1r8qSUWOU3gATuZ1dwsw?=
 =?us-ascii?Q?Gzht3tbAOfLYqzWHd4k5BCsSctE/hJaMghDl3QODo8TQBuL0RMiLRgehwLsS?=
 =?us-ascii?Q?Skwfdh60BYWqBycvVK+9vB+wk6XtYTOyQ5UoTss0cmeN1FDXDOeBDFfhewjx?=
 =?us-ascii?Q?HcgCsmaCEpTFIErBb0Oukmn9/exG/jCSuxqNkFbZv/NizWBw7jPl3ENYWicA?=
 =?us-ascii?Q?AErO3HCGxGMFUE25pLgz9la7TGckAaPS2/054aIyk7kMlP57TGaY+q3dGWGY?=
 =?us-ascii?Q?FkbHY0zNOiRc5NdL+9eCLvH7KuuF1MKZQojuB3G8wDca1wIeETTttXcsGJCu?=
 =?us-ascii?Q?n6G2Y4R0+OjhUtYOQIlWoOIlt32qCzGr0+YeHZiWDqQBurWbWVrLDqd3x00B?=
 =?us-ascii?Q?QmhBrUE+sZI0kYvNt8FL1aZy6r0/xrfpoVtJTb8uIUuErwtZlWq7AGhVIuGr?=
 =?us-ascii?Q?wLe7HpkLjT6KES790eFmCA3XmyccSEf27zYzNBLMua1GsF4i/REmvR9e7wKh?=
 =?us-ascii?Q?AwFXUCdITNh5WFz2790Mr8zzMr91gXoYFbgRF3BQV/Id1JZqVT0ny4+YI1zy?=
 =?us-ascii?Q?mQJARQrNhn5f59cSUtjayWEgmvkQsbGtBlM8M/XPP4CQCcK48SLpOp6xpY99?=
 =?us-ascii?Q?D3s7iTzJN6tXCM8RynD61tnCQf79VS7VfI9HvX35nrwN9qBm7mgO4gn/RI8g?=
 =?us-ascii?Q?UEhp5NMlDz7E6WCKvsp1iaqUsFWPUwGtpxuQ3gvJNc74N1RplNt0HS/irTU4?=
 =?us-ascii?Q?cAyHKTAyYl8MeCNRP8IhHWnwJBoHV6mCZTwIuOVpXFazcXp1R93isurwWE5O?=
 =?us-ascii?Q?49NolZuvI2T1BnWC0O1x88Dmov8VrhubOhxjj07Z1OjSo5cb96fukC+5BbIL?=
 =?us-ascii?Q?GCUUj7XVEBwRG96P5pkDXcHpW93Js5cHAKNqB9UmEZ4zFAHizgYXZZtsr7an?=
 =?us-ascii?Q?02OoVwwPnV68yDxLUj8KGQMo5uNaQDmcGsD15ACXNC0pHcE42+hBT/fX5tXc?=
 =?us-ascii?Q?LGb2r6PZ8c6TWRhcVHeNGg6XCX+31txHeWPJg+rvTG38DqdTor7CayFlk6SU?=
 =?us-ascii?Q?xRT5xd7EF0lkMOerrYviXV3mBu34TJOcoDy8uDsVciUNtBFARQ+0?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f60840-8b3f-4196-c671-08de5d5504c3
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 03:34:46.7248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1iyF4tB7EKyXgDTDSfjDtWyUkQcQXhJQCw7GC7jiMQipfzzeRIPnBGKjicpoR3wZbZKbiwNHPN04BBH/AVCvzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5626
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-8525-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,gmail.com,google.com];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,valinux.co.jp:email,valinux.co.jp:dkim,valinux.co.jp:mid,dw_edma_chan.id:url]
X-Rspamd-Queue-Id: B26018FA6A
X-Rspamd-Action: no action

Some DesignWare PCIe endpoint controllers integrate a DesignWare eDMA
instance and allocate per-channel linked-list (LL) regions. Remote eDMA
providers may need to expose those LL regions to the host so it can
build descriptors against the remote view.

Export dwc_pcie_edma_get_ll_region() to allow higher-level code to query
the LL region (base/size) for a given EPC, transfer direction
(DMA_DEV_TO_MEM / DMA_MEM_TO_DEV) and hardware channel identifier. The
helper maps the request to the appropriate read/write LL region
depending on whether the integrated eDMA is the local or the remote
view.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/controller/dwc/pcie-designware.c | 45 ++++++++++++++++++++
 include/linux/pcie-dwc-edma.h                | 33 ++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index bbaeecce199a..e8617873e832 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -1369,3 +1369,48 @@ int dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dwc_pcie_edma_get_reg_window);
+
+int dwc_pcie_edma_get_ll_region(struct pci_epc *epc,
+				enum dma_transfer_direction dir, int hw_id,
+				struct dw_edma_region *region)
+{
+	struct dw_edma_chip *chip;
+	struct dw_pcie_ep *ep;
+	struct dw_pcie *pci;
+	bool dir_read;
+
+	if (!epc || !region)
+		return -EINVAL;
+	if (dir != DMA_DEV_TO_MEM && dir != DMA_MEM_TO_DEV)
+		return -EINVAL;
+	if (hw_id < 0)
+		return -EINVAL;
+
+	ep = epc_get_drvdata(epc);
+	if (!ep)
+		return -ENODEV;
+
+	pci = to_dw_pcie_from_ep(ep);
+	chip = &pci->edma;
+
+	if (!chip->dev)
+		return -ENODEV;
+
+	if (chip->flags & DW_EDMA_CHIP_LOCAL)
+		dir_read = (dir == DMA_DEV_TO_MEM);
+	else
+		dir_read = (dir == DMA_MEM_TO_DEV);
+
+	if (dir_read) {
+		if (hw_id >= chip->ll_rd_cnt)
+			return -EINVAL;
+		*region = chip->ll_region_rd[hw_id];
+	} else {
+		if (hw_id >= chip->ll_wr_cnt)
+			return -EINVAL;
+		*region = chip->ll_region_wr[hw_id];
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dwc_pcie_edma_get_ll_region);
diff --git a/include/linux/pcie-dwc-edma.h b/include/linux/pcie-dwc-edma.h
index a5b0595603f4..36afb4df1998 100644
--- a/include/linux/pcie-dwc-edma.h
+++ b/include/linux/pcie-dwc-edma.h
@@ -6,6 +6,8 @@
 #ifndef LINUX_PCIE_DWC_EDMA_H
 #define LINUX_PCIE_DWC_EDMA_H
 
+#include <linux/dma/edma.h>
+#include <linux/dmaengine.h>
 #include <linux/errno.h>
 #include <linux/kconfig.h>
 #include <linux/pci-epc.h>
@@ -27,6 +29,29 @@
  */
 int dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
 				 resource_size_t *sz);
+
+/**
+ * dwc_pcie_edma_get_ll_region() - get linked-list (LL) region for a HW channel
+ * @epc:    EPC device associated with the integrated eDMA instance
+ * @dir:    DMA transfer direction (%DMA_DEV_TO_MEM or %DMA_MEM_TO_DEV)
+ * @hw_id:  hardware channel identifier (equals to dw_edma_chan.id)
+ * @region: pointer to a region descriptor to fill in
+ *
+ * Some integrated DesignWare eDMA instances allocate per-channel linked-list
+ * (LL) regions for descriptor storage. This helper returns the LL region
+ * corresponding to @dir and @hw_id.
+ *
+ * The mapping between @dir and the underlying eDMA read/write LL region
+ * depends on whether the integrated eDMA instance represents a local or a
+ * remote view.
+ *
+ * Return: 0 on success, -EINVAL on invalid arguments (including out-of-range
+ *         @hw_id), or -ENODEV if the integrated eDMA instance is not present
+ *         or not initialized.
+ */
+int dwc_pcie_edma_get_ll_region(struct pci_epc *epc,
+				enum dma_transfer_direction dir, int hw_id,
+				struct dw_edma_region *region);
 #else
 static inline int
 dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
@@ -34,6 +59,14 @@ dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
 {
 	return -ENODEV;
 }
+
+static inline int
+dwc_pcie_edma_get_ll_region(struct pci_epc *epc,
+			    enum dma_transfer_direction dir, int hw_id,
+			    struct dw_edma_region *region)
+{
+	return -ENODEV;
+}
 #endif /* CONFIG_PCIE_DW */
 
 #endif /* LINUX_PCIE_DWC_EDMA_H */
-- 
2.51.0


