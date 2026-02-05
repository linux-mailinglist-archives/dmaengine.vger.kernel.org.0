Return-Path: <dmaengine+bounces-8749-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKlqCOs9hGk71wMAu9opvQ
	(envelope-from <dmaengine+bounces-8749-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 07:51:23 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF5AEF1A3
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 07:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 148E5301DC25
	for <lists+dmaengine@lfdr.de>; Thu,  5 Feb 2026 06:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9DE3563EA;
	Thu,  5 Feb 2026 06:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="DLUe/xai"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021075.outbound.protection.outlook.com [52.101.125.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29803559F5;
	Thu,  5 Feb 2026 06:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274267; cv=fail; b=p4iFrDFC9pi1dqlNX5oUMpvjMH9hbcN/4XDfj4cUb2LIACJPB29ACOOKo/WUmmBQyNIVmnKpXQuBOYPOYHazIehfKQJ5OCx/gLiC3azMtHo1xEvgDyUqHCRNHYxGhzidZbbfAvJEdbUvFl+Nq79mSMaBNOq3tV7CSEAKGlZ1t7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274267; c=relaxed/simple;
	bh=dJIymy/azPzt3ef7LcB9SCiDh3KbSsAmFVRF7dn7W9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Kf4pikkJUoQtnueK+UNIMMrrn+QzzdinNtpdy6nxWPxriChM6ppcM3OueGrlvBabYoJ8YuznRUE2BGw0/YwaPbUPe+3egDvFnsS4u8iWV89M/SBR3DpcN4IkeUeRD3wdT32gatgwpQj0Cgr8PquKk13MyncKe1qW7xfhHdIOSi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=DLUe/xai; arc=fail smtp.client-ip=52.101.125.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCYGG/ma7BUGTexaq3FX5rqqXHl4wZERhA4sm6hEOlSHL5c5TDojZ5X7FOtI67HZYDTx44YBis2VhLA8yzHobRiqvfsCdug37wkf46/KzVxAbXPjQFuUUMXTEOGXysr7lcRlhWj3HzxkBWBA70mDeq5a4yHaLC7l230FPwGvjC6CIeuQWh0Pk1NAu6NaIvXgGFbTmAWxREtM2ip8jTzQOVPK3FLRlOKSqQ+9ziF/GQ7O+5ALZaPD+WpDnEKRnG5Hx0P4V8uCA2+q8TlGkialhG+bwP9Y4TCM4JbwqDP/BaRib7EyFNfYPTuTdvphuiykx3CoX18KIrLIEI/sKXUN+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5oEHxF5PymTYc+BnygvJtbjEtMv+eaN+VGJ0Aj/z9c=;
 b=mZARAzbe0QrOcCYs060+6qH+7t8Li0sED3xvJ7LsCfAgPE+ulntHavxbJ7AF7Rk1Y+VJtV2nj6X13aqKtjEnGYmbR98Uc7KUtfRnw98J1jcllS+BasU4hL1Lq6vj8Kz10W1jqwvqttPdnsX3WFCf+kOclMk5XA9+mBCH0bNYMap/qv4WxAL+nkDKDPG719Hkr+fFOEBD0URh2Ludi+2gS7OMIDGzO6hdyCDk54akppj8VoiyuQYPWgNvYS6Qh3byyBbzDUrwPPv6DpRpMTUtzvUw3pDqCnleofNpe+DlLPYG2lWleDxEtV/4R6qXykYPifd3Rwy7s9toGzsqhIbZEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5oEHxF5PymTYc+BnygvJtbjEtMv+eaN+VGJ0Aj/z9c=;
 b=DLUe/xaih/wgNruOmDUcqKWEnmMcsmXPNaQCoLI/quNy+fWvFdru8YSAGTZVcHRY7u1ZYybBFN7AHphMHKU6WogxqgyuaPQz5DJjS13dQtSHICVmNKiIn99YMFRghLsWrJwcmu2tQqIhtA2niML6OkzazLqEcDCmhjMtatt5VlU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB2318.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:171::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 06:51:00 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 06:51:00 +0000
Date: Thu, 5 Feb 2026 15:50:59 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: vkoul@kernel.org, mani@kernel.org, jingoohan1@gmail.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/11] dmaengine: Add selfirq callback registration API
Message-ID: <p4ommmpcjegvb4lafzecf67tzmdodtuqexeoifcn5eh7xqyp2y@ss76d3ubbsw7>
References: <20260204145440.950609-1-den@valinux.co.jp>
 <20260204145440.950609-5-den@valinux.co.jp>
 <aYOF_JNYZF9IFUCr@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYOF_JNYZF9IFUCr@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCP286CA0330.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB2318:EE_
X-MS-Office365-Filtering-Correlation-Id: 17adb251-21fa-4d51-bfd5-08de6482ec4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dc4a+NvsV8C3C/zlvRPf3J94QGj7mSqyD/5WvGlfk5HywZeKtaAttQY1Pdfw?=
 =?us-ascii?Q?v4SHtLZyYyQ7sUfs1Efg31+ncO3UwqH7x55iHRJV++DYDH+pcdCvFP84bTK8?=
 =?us-ascii?Q?cmrdqnLPqFIFCzzQrH+JHEdSUGBKefhf9w7Nen2YGwxbQqQQGrh5qY3C64+2?=
 =?us-ascii?Q?RgDx2WsDNv1Ul6vPDZX4Zf3Hlbc5No/AhSHyo8jQdb29JkYihvxW8HFRBmaq?=
 =?us-ascii?Q?IWl30J1wQlHGu/n1LQ1EWYOa4nKgPuv5USMBrXwFO11vx1P5nJY7DsNZqnB5?=
 =?us-ascii?Q?YM6seVmLGUAMfsg2YsbKxh66tXuD8m9dk1L429sE0/RN3I9Vh+dlm9X30b0K?=
 =?us-ascii?Q?S7CHdBgSGBKi1jnHNS2KCdEuCfU9IIIxLTGrax3IyK7zkLTBlgh3ihjM61Zx?=
 =?us-ascii?Q?vzLw41BN5UTf7Dn/3RVBzyRWhPO5s46OiWKvvWITDZz5MZBU5bOscdAjv3aN?=
 =?us-ascii?Q?Du7uAHXEslSxAEu2naX0h/CrpjoTarzHE88QbA6jM4E6SxHWA28CuSDKrUF+?=
 =?us-ascii?Q?XeYb8fqDpFrYR7RsZ2FLeWNwhjmQzz6+BxOccg4pJiq5JnuIkhQieYTeaPlN?=
 =?us-ascii?Q?VVSOIZZSPksPJ7O6UG8MDtXCOiMBLqdV2iYOpiIoL+Ll6hzCHqXxNW1SQOsg?=
 =?us-ascii?Q?DuF97e18E+WpMUEAqSjAxohxovcIZnlXDresIRMukbQTCvInPhSkJ66iMoai?=
 =?us-ascii?Q?lHrsm1lL2mPHWWOL65MDFBy8AiTR8uKH8e7Qr5PPMhwYPMbu4dB4ISgnolrd?=
 =?us-ascii?Q?PWzjj6UitS60m9/Bw0NIhferJ2C9aMol1K7JWDa1KP88Vn5vFLsxy3dfxPOX?=
 =?us-ascii?Q?bq8Kp5Q5RJ/GOVp9v8CCtsI9QKsNKk1aHb/McJLhXDqqzVeksK27u3GORox6?=
 =?us-ascii?Q?l1cvKXSmwRVRGb3OImOiU0Dlg71NPL7yfdf1Pvuacq5rRDNxTd895cxow3wI?=
 =?us-ascii?Q?Pm1BQBJ2vtK3mxMzx3FZMK6NxISjqUKxxudnq26nkRCrnnOq/5b11URI0Tsl?=
 =?us-ascii?Q?LWWcXXxV/zJUDGuNPMyAgocMd4S6Di9slbubgbgMasmD2RmbNM/Ocv2EUHoo?=
 =?us-ascii?Q?9VoEAuNzKFq8leGQY1AEMjABsO9NH8PkgYjmnsiiH5v9m/JsMnBaFg6YK/eu?=
 =?us-ascii?Q?cZ4cwQVVIv0RPxs3ZDksMnQHxuYvnZyYjbfPdQvpyPZKTVcf7O4f9jzqQqvL?=
 =?us-ascii?Q?38Wor07YNu20D7YQjyZRLk5GxPF4dYe9rqnltf02LOug4Ji2fRJEfTiYU6a8?=
 =?us-ascii?Q?hm0/luv/ihTTlAUlHpqX6h2H/7BEZnlMzNZMHWAAsiV0ZF4jvN7Bt69dI5/d?=
 =?us-ascii?Q?Is1Ll+uYhDpZDRPJ4lVqMsR+b+7yJKBJh+K9onMEkJ+7RxgfKRHNNdZY6ELw?=
 =?us-ascii?Q?q9BUBJa3yjEpkg/r4OdSQObbzbj8nZx3DiBxqUJthEI+Q2zR1RB/v7pfoXpm?=
 =?us-ascii?Q?oDoW5EaBwFcBb96E7gSoPzoMjO2aeHjZs+syfEGAegotzYjU6lRZ67cHr6Tl?=
 =?us-ascii?Q?DL+jDFXJeFV/+MF6UYwh4vOpbDl6J4GefGppZn3TB1WtY3cMRKsq2BAbSNZF?=
 =?us-ascii?Q?iG2nbZ75bBkhSmJp0uI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4lM66DuqGCVOxeHWodHEEtt8u922hZVKQpaVkNOzkOFVcBSKMVgBuWGQNyBr?=
 =?us-ascii?Q?Dx2BTP4PVLKw58bakBpw3epbMiS2Hswv+k0tQTw8zFR0AWhvdZzY+2K1x/DA?=
 =?us-ascii?Q?Tb1MUg5K0bG4giT2ohsjvtGID9332ZHp3/zmd+6hyCDv8wXZhNac4gol7Yge?=
 =?us-ascii?Q?jJtgMGLY/5cnQ4fbpV9qnbRvyZGrxFfPVQuwEwB+mDXqZmtXwYfF0IuBKCVy?=
 =?us-ascii?Q?FgVMruJXHWawmASVeKL6tCIac16ShHW0AQFClgZh7Y78umlSmSUob8n/7tRa?=
 =?us-ascii?Q?Zkh9RnYN7Cnb5dHH5nqAzhDoRi7BE2mjuL/fycjCVdOOUYMtGjM7oVuGi3Tn?=
 =?us-ascii?Q?CDtpXTmSJnIyWWRNHNT1dC9Rz/NK34+3G7sBFGWee7nTc4obiE8l8OzQeqHz?=
 =?us-ascii?Q?JreUoRiSvkX8cfU50SkaXleQm4ndcN8oSnEl8O6yuA5Pl4B2/lPxDE/RHTKu?=
 =?us-ascii?Q?7ySPxIWO6K8rkvVr2lhEWzm6JKYPWxQtLHsYEcXUAZl36GVdq5Ku1gjkLblr?=
 =?us-ascii?Q?VqjjnnwSNhWls7VZjHGxlr9SMd5set85Gwl27quqiYu5YKkLEgBHCZAmcewI?=
 =?us-ascii?Q?JG/+n6Yzhwcr6/exXt/kpBqvPZ2iLrG3a8pfrDGPM5pfetXsMqBxQY+Ii+CK?=
 =?us-ascii?Q?6EfTtC/XQGHLKS5bCnHJLflE8y8/EVYmH/9mnHDXE+QP1pw1eCGvvAnzA9qn?=
 =?us-ascii?Q?N3u38hsp9GQoOx0nQwI//wtLHiHako/bWuqNRBEc++HsCoaweOwIaL2yTQ1v?=
 =?us-ascii?Q?+WQCzo+IjEG+gHf+wrKbrsVSaI0q6rFJrxMb+pDL1oJQ0u1VlgALoq5Xj+aQ?=
 =?us-ascii?Q?3hMqUjmpJcqT4Aynq5P5eXgID905eltNDPk8GgotvhQ9mie/rc0c7moaSoIh?=
 =?us-ascii?Q?jp6ZyxcRzonCBODKkivAFrdOeu2c7+CPmzNmXhb7RNtK09cnjN8eapgtDHZz?=
 =?us-ascii?Q?6iirghUD48BpTuA1M2QazRB2ZQUTiexKE33YQYao20VpFi9T8yG8unI1lAGB?=
 =?us-ascii?Q?SdEQnPRGq3NltVfpHdlFL+2fCZQa0n1lD+P9GkFR1G6gDt8+lxN4RkDvufsL?=
 =?us-ascii?Q?+R9MkPgTuDcGJGIRFXHaDbhNsWrz8UHzORzp7dwwKf9n9akidabFceF2E7rN?=
 =?us-ascii?Q?vPyFI2nl01VnEgAYTE0go3fCiPsHIwS6NMEMC6edl9M2WFEIIKGMA/B0rqfj?=
 =?us-ascii?Q?O5+OwMcJe1igBKm6wJpGyPw/fexvMpXind4KLd5nIueTxf23iRGXgqyx6dbz?=
 =?us-ascii?Q?6AKQQyIHnbuXWcRlrwTVJF8eLWPFRLSH7iHHpsgtTmzAcRE9JyzolsoKuKwU?=
 =?us-ascii?Q?DBa87OuAjps36r8jS8CDT1prC04KyoDct/dH2LfIc8kRMXxz+NodDjWDVj4N?=
 =?us-ascii?Q?4L/9dmKrxfB59gCwsUjdYRfr5VFRCaTrxR0bswe1lSWnD7eo6xilLuzL0jRU?=
 =?us-ascii?Q?HkbWWhLMZK1Ew7upJm4VBmTtAuQnW7MfNdRgyBq1zBfGHzLcyy2HDfHeu087?=
 =?us-ascii?Q?z1qirR9CGroHId/vSiEEevSa97nTUj0iiXp3J+YNkPQROwkkx86TE4jGG0Os?=
 =?us-ascii?Q?IdstFp+9f+L3c4dz7H9FnBmWevIuBgCMzRJxiPDgzrDFMIBS8rdTATTZMLRH?=
 =?us-ascii?Q?puQjyD/WiNFtKBaB/ZHogTQcpb02z0+sr4uCmbBEuyNtrvUZlJ8deDPBXuYB?=
 =?us-ascii?Q?1mVBifQ2xHIGo8Scwv/0Lg3Tbn9UV6ygpFCKnCsqWDVWwxqMvx2sh9BcOmHe?=
 =?us-ascii?Q?9i8myR5UyOaS4/IlWhayNPnXrtV+h6qSl2qOcmqE5UoWHIxvUKBQ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 17adb251-21fa-4d51-bfd5-08de6482ec4a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 06:51:00.6666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: he8wqp+31HR1Dcs9HpC9F/mjwcgrgszmipnbk01X55Zqbl4WmMnnOFAPKCEtWqZvbeXTnRYMYgS9dkiUaHQkrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2318
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8749-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ACF5AEF1A3
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 12:46:36PM -0500, Frank Li wrote:
> On Wed, Feb 04, 2026 at 11:54:32PM +0900, Koichiro Den wrote:
> > Some DMA controllers can generate an interrupt by software writing to a
> > register, without updating the normal interrupt status bits. This can be
> > used as a doorbell mechanism when the DMA engine is remotely programmed,
> > or for self-tests.
> >
> > Add an optional per-DMA-device API to register/unregister callbacks for
> > such "selfirq" events. Providers may invoke these callbacks from their
> > interrupt handler when they detect an emulated interrupt.
> >
> > Callbacks are invoked in hardirq context and must not sleep.
> 
> Is it possible register shared irq handle with the same channel's irq
> number?

The proposed dmaengine_{register,unregister}_selfirq() APIs are device-wide
(i.e. not per channel), so I'm not sure which "channel" you refer to here.
Also, when chip->nr_irqs > 1 on EP, dw-edma distributes channels across
multiple IRQ vectors, and it's unclear (at least to me) which IRQ vector
the emulated interrupt ("fake irq") is expected to be delivered on.

That said, technically, yes I agree adding another handler should be
possible, as dw-edma currently requests its irq(s) with IRQF_SHARED.
However, for a consumer driver to do request_irq() on its own, I think it
would need a stable way to obtain the irq number. Today that mapping seems
platform-specific and hidden behind dw_edma_plat_ops->irq_vector().

Would you prefer exposing a helper for obtaining the irq number (or
exporting the mapping in some form) instead of adding the dmaengine selfirq
API, or did you have another approach in mind?

Thanks for the review,
Koichiro

> 
> Frank
> 
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  include/linux/dmaengine.h | 70 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> >
> > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > index 71bc2674567f..9c6194e8bfe1 100644
> > --- a/include/linux/dmaengine.h
> > +++ b/include/linux/dmaengine.h
> > @@ -785,6 +785,17 @@ struct dma_filter {
> >  	const struct dma_slave_map *map;
> >  };
> >
> > +/**
> > + * dma_selfirq_fn - callback for emulated/self IRQ events
> > + * @dev: DMA device invoking the callback
> > + * @data: opaque pointer provided at registration time
> > + *
> > + * Providers may invoke this callback from their interrupt handler when an
> > + * emulated interrupt ("selfirq") might have occurred. The callback runs in
> > + * hardirq context and must not sleep.
> > + */
> > +typedef void (*dma_selfirq_fn)(struct dma_device *dev, void *data);
> > +
> >  /**
> >   * struct dma_device - info on the entity supplying DMA services
> >   * @ref: reference is taken and put every time a channel is allocated or freed
> > @@ -853,6 +864,10 @@ struct dma_filter {
> >   *	or an error code
> >   * @device_synchronize: Synchronizes the termination of a transfers to the
> >   *  current context.
> > + * @device_register_selfirq: optional callback registration for
> > + *	emulated/self IRQ events
> > + * @device_unregister_selfirq: unregister previously registered selfirq
> > + *	callback
> >   * @device_tx_status: poll for transaction completion, the optional
> >   *	txstate parameter can be supplied with a pointer to get a
> >   *	struct with auxiliary transfer status information, otherwise the call
> > @@ -951,6 +966,11 @@ struct dma_device {
> >  	int (*device_terminate_all)(struct dma_chan *chan);
> >  	void (*device_synchronize)(struct dma_chan *chan);
> >
> > +	int (*device_register_selfirq)(struct dma_device *dev,
> > +				       dma_selfirq_fn fn, void *data);
> > +	void (*device_unregister_selfirq)(struct dma_device *dev,
> > +					  dma_selfirq_fn fn, void *data);
> > +
> >  	enum dma_status (*device_tx_status)(struct dma_chan *chan,
> >  					    dma_cookie_t cookie,
> >  					    struct dma_tx_state *txstate);
> > @@ -1197,6 +1217,56 @@ static inline void dmaengine_synchronize(struct dma_chan *chan)
> >  		chan->device->device_synchronize(chan);
> >  }
> >
> > +/**
> > + * dmaengine_register_selfirq() - Register a callback for emulated/self IRQ
> > + *                                events
> > + * @dev: DMA device
> > + * @fn: callback invoked from the provider's IRQ handler
> > + * @data: opaque callback data
> > + *
> > + * Some DMA controllers can raise an interrupt by software writing to a
> > + * register without updating normal status bits. Providers may call
> > + * registered callbacks from their interrupt handler when such events may
> > + * have occurred.
> > + * Callbacks are invoked in hardirq context and must not sleep.
> > + *
> > + * Return: 0 on success, -EOPNOTSUPP if unsupported, -EINVAL on bad args,
> > + * or provider-specific -errno.
> > + */
> > +static inline int dmaengine_register_selfirq(struct dma_device *dev,
> > +					     dma_selfirq_fn fn, void *data)
> > +{
> > +	if (!dev || !fn)
> > +		return -EINVAL;
> > +	if (!dev->device_register_selfirq)
> > +		return -EOPNOTSUPP;
> > +
> > +	return dev->device_register_selfirq(dev, fn, data);
> > +}
> > +
> > +/**
> > + * dmaengine_unregister_selfirq() - Unregister a previously registered
> > + *                                  selfirq callback
> > + * @dev: DMA device
> > + * @fn: callback pointer used at registration time
> > + * @data: opaque pointer used at registration time
> > + *
> > + * Unregister a callback previously registered via
> > + * dmaengine_register_selfirq(). Providers may synchronize against
> > + * in-flight callbacks, therefore this function may sleep and must not be
> > + * called from atomic context.
> > + */
> > +static inline void dmaengine_unregister_selfirq(struct dma_device *dev,
> > +						dma_selfirq_fn fn, void *data)
> > +{
> > +	if (!dev || !fn)
> > +		return;
> > +	if (!dev->device_unregister_selfirq)
> > +		return;
> > +
> > +	dev->device_unregister_selfirq(dev, fn, data);
> > +}
> > +
> >  /**
> >   * dmaengine_terminate_sync() - Terminate all active DMA transfers
> >   * @chan: The channel for which to terminate the transfers
> > --
> > 2.51.0
> >

