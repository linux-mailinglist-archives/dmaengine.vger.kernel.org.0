Return-Path: <dmaengine+bounces-8484-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMcwHeIZd2kCcQEAu9opvQ
	(envelope-from <dmaengine+bounces-8484-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 08:38:10 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E74C384E54
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 08:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E28730036CD
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 07:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDE62D94BE;
	Mon, 26 Jan 2026 07:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="H4Bzx/Dh"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021142.outbound.protection.outlook.com [52.101.125.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0884E2D8799;
	Mon, 26 Jan 2026 07:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413058; cv=fail; b=Epf1D5jDVsOfK2+P4qL5gow28otOFLuNk56tr9HPhiWmb766UGIDmuJspmKsiPnSE56jA40ZiKRfsFy7TBWra5zNy8mf8elIAKAQtMyz4jNWf+3zdVNIr+1oMFCwM7f8ToCIAzI0ar/by3qYoaPJiRE6HBmogGr1YYksAnqrcE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413058; c=relaxed/simple;
	bh=pnpQDCI0F9JfNwYrx/w38o7aP5dHa/6k9qd6J3bGHTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XoCul10ouiAqzKJNwANPOTGUz5Pi27TASAaZjG49XYY6zLKPrDdnOURQ66rEN/B/Hc3+kKBO4tHPzq/85GXzD4XqEV/1G4a4ZrZ7uc9+Go+vyI2m0QJ30wcQji8bXpoVTcvPzHDyZ7j+PRhp8W5E+zL21HnN3D4hBgEeiPpQdxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=H4Bzx/Dh; arc=fail smtp.client-ip=52.101.125.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TLQartc+14YUufN1SJal73//HOjNYxuEAYS4tFYTkCapRYnQO6qEmt5zzkLJFBZS5kj15/wlVrCIwZfWmbd5u0GXknKL16o4SzSPRJiidmJweesHYH4Shzu7mYt9uO04HLf6/vas4FWcMN1mY1IoLS6xmiCEoC1GPCKLOPb4vgjyH1l1XuNb8gpVwJzZhoE2ha8VuJqJXVLMfRHBtXoKi7OZMDN6orHZ/Xcg8vsyDUFMzkigMHFHePQN+CBtfGO+lhi5hpKhMuIkml1nruITlRnxaDNoiVnBUqgC+cs5guONDz7N0OOhCwINe/0At7PaOnw+B5Ohnir4vjo70dGjwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmYCC5G3eZrcEMmY1Onjcyk7KDId4J49Y6xQAasw9TA=;
 b=N0z8eJofcSGNM1sjJjrZvoQ8w54Pzr2iLa4c2IeXRA02jvgxYzvtCaRVKxR4DGC/lAoPDne43qgW0e75S5loFaDWKfsXshtDf2Im3Ho1NQ8zcqNdiU2B4b3n8hFfYHScKdJt/bPD1lD8m0YE6aYQpmVfyLS3mZ2amUBszxDgymDL+F94Rpmkcly5PW6GKhGI7YZYsgrQL/gUZ146QFYGwj+E7q18EiBPfLWNCRwqO7z/afXqJAinZQSsgMJVzilnw2l2g/aeLhAZMsqojiPfO2qAS1II+LhoZhWoNlZCxtcc7+XtArPu3MRsdZcOr82J9O9RKuxhMhVnKFUdrhIzsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmYCC5G3eZrcEMmY1Onjcyk7KDId4J49Y6xQAasw9TA=;
 b=H4Bzx/DhoRkf4N1+Iw3smIxNW7SngHHgxwt+MSwCCK5irw3ed5IqYcTOmwTOjDCMsDUKMYQsrdT91UiAnXyE7SB1ChAQ1nNiCDrMPnel90XRJua/6ydXpxPz63C3BummxVqHg9dj9uKb8amvwpB7/Sgj7Oh1jSH+2fYvH9cXGDY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6300.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:420::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Mon, 26 Jan
 2026 07:37:09 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 07:37:09 +0000
From: Koichiro Den <den@valinux.co.jp>
To: vkoul@kernel.org,
	mani@kernel.org,
	Frank.Li@nxp.com
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] dmaengine: dw-edma: Poll completion when local IRQ handling is disabled
Date: Mon, 26 Jan 2026 16:36:51 +0900
Message-ID: <20260126073652.3293564-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126073652.3293564-1-den@valinux.co.jp>
References: <20260126073652.3293564-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0354.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: fb967a29-7a30-4755-a7f8-08de5cadb64e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NlhQ2ztrr19viiJ43r12l9IG2RY1J/DAOc5kxZU+hR8HCwSz0N9DeMToRC4m?=
 =?us-ascii?Q?goZy73+nJTGGMhFIls9AIjFlSryQDnzOH13LabCpYoGvNTe3hgi+/yy9WXdQ?=
 =?us-ascii?Q?+8N3lb7ph6t4GQnxhCunYqFY8CGdIr2TOIiDLJJ40JGtXDEPLfx653icMUMC?=
 =?us-ascii?Q?f7Vxvp/rFOM3qzyZHyXPLT/xGYqPMgKQF+3wCDjePgbpGXB2klZZJOES0rTJ?=
 =?us-ascii?Q?Vvk3JF3ck3dHaX1w4tzaZqbGvfjC+hwj41o0aMs210d5vPEZPtYxTBFj/iAU?=
 =?us-ascii?Q?75x0tIghhUWPCMIrMyTX1dtJLeemxZRsjJX9y13bIiYnZ/GiWD6fZ35GLqUJ?=
 =?us-ascii?Q?puTWnuqrBTlhC7V3Ywy7CPuUdl2S3BXWw5+sFQNngCSNWKIaKh14pQYTHDLd?=
 =?us-ascii?Q?gT/UR13lihTcQrEaX0hrPzDefEFtpkBgb8jMH7eH/TjOOJf8brW6oj0DTImb?=
 =?us-ascii?Q?Aipj67JaqwAMiJQ/6Iq9776zUWHK8aPaAKGv/ofvdnEgxe61i7jBblD7g8Tu?=
 =?us-ascii?Q?+FLh3xklvupPbYrJKabVy5krnTuJLs8n5tInhAv9oU0xYq8XKhSoE5DzOBaB?=
 =?us-ascii?Q?gx1nBWZIKDW0PpJdKrvJeB+toX422vLebxTJWd6BkDkCVocETM3C44KXCqFi?=
 =?us-ascii?Q?SHnO2g2JfO8xz5AMrta++5SczQpOf70wk0dSznGX8S/AY/z9VdZS1yDqtb3o?=
 =?us-ascii?Q?EJ0Ezr4wiA9JtezMk3fPgTMeNxc7vJQlnX1eeWI3lWrpY92WQM9pagV5Bg/r?=
 =?us-ascii?Q?iaVmXY91Nh2hfSm6WhaNPeF64WjXc78Vx6aeIrbrdKrADYLLzhqePPvS9wqb?=
 =?us-ascii?Q?IkJF/idMifo+adP8aIPGSXT9u0c8puIafFndZZTAqrNMe3hMIdwD+y7sxCwZ?=
 =?us-ascii?Q?+5YiV7CfqStmvlpYd9+PKCYejaifUFCH0QJHwoYnHtAerI+Muza8D+xM81tE?=
 =?us-ascii?Q?okeNFLvHo5r09bpub19oj19xtxEK6QuqcsJc1uZwa4jyHVCOTXNyuw01SH/V?=
 =?us-ascii?Q?RQA5JjJ2kyCIlbwhK2ejxmBRoD5DfhlqHWoaZqxvH4TZhnZ5ZO+lod3RZQji?=
 =?us-ascii?Q?gXznpmi6HbFHXAWjbyexKXvB7InG7y2JAAIqrAEeXpDm2vY8MDcX+HmnOqgX?=
 =?us-ascii?Q?OpIN6cEIcrw4n2FZO9Gp0DhOKNd5+HX/YJEnIu+kqdGdSTTIYe+ki/Zf4u8J?=
 =?us-ascii?Q?2xAS/491Yu7NGTdSMVWb3SlrI1BwuyVDEGAfF/+nQlrFrCOVHGAd/6bs5t7Q?=
 =?us-ascii?Q?hd4bfiDRX0f4nliXd1YVl/9DVuQVxLfkBkQ2eTM8n7s44/3JsI6V3IZoJOs5?=
 =?us-ascii?Q?GVGx5UhXTCfty1vK788iMfiXboQk2ja2oK6Mu1R4pYGkzQwPVAYR9IfbUX24?=
 =?us-ascii?Q?bxgSuoNpjUedZ8uJ0s/73b4RgrcUyJT8zrvH/QAtjE13N/G2jZFsa6ocvq3s?=
 =?us-ascii?Q?KnbscX/CWglH6Au7QJyLp/DeO23taIolvyl8wVNrGajbUizOyLBpygGTOtHz?=
 =?us-ascii?Q?suDVl/3B9p/NteHMM2aFhsSVdIbiiOH5CpnmlOP/7H1WCAPyesQYGTUnWdQn?=
 =?us-ascii?Q?9IlnlMRWKlJuGTiW/kc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?obqIfrU8ChS+ZyjImAY6L2tw3I1tMq2n+dUSyqYgApGR+W/TtXD9h043S52i?=
 =?us-ascii?Q?9jTUU8rc8n2CBsiEZFDxL8F0i9fMKF5Nrfl19fSBkoddL5X9fJOsev8h0gq5?=
 =?us-ascii?Q?OIyx87vcvzSfgYbTuhou5N2OLXDybUryWAyCBGkc6rurqUvw1IgwLuYsEKya?=
 =?us-ascii?Q?r2B7aYAjWddSHS2KzyWgKdLPj2Ar6HXgUOAx/GtBONTsnWH5fPQlIvxLw0jI?=
 =?us-ascii?Q?1E0IAbQDKofESaCYmQ8I3Py3Q0RVdug3RpmbF3j5LbnbQ74GIK9gAvTg0+13?=
 =?us-ascii?Q?E2+vP0oVXnbBaGKx1iTC9xSMtfvDBuSpwqiIs/h0Da8fxrTkYBE6ZETd6rVF?=
 =?us-ascii?Q?N+PlVlZys/Nxisfcvf0QAjT3oioS65XM++lAo9niqGOrCBE+qBICCg1AomCX?=
 =?us-ascii?Q?64FalHB2V4CK5U9/ZOnXPWYyeV+pmi2bMe5gj92yIRVz8TTCvcJNBZOHks9t?=
 =?us-ascii?Q?Rz7XqlgoqBo5bAisb0TkJPSOOIXkqVSa+szc1pUnNGxUYaK0v7LfdKgdariH?=
 =?us-ascii?Q?yMJk6/CAjEL0HAaASAK91+EGXMysGw1USHPOy6XG4wjkr0soVa+TPVFgYu+f?=
 =?us-ascii?Q?P7A6OkyPpih1FZ8JF4P6cqL0BSXs2BOKrYgn6W3Necff1E8HdfwmTcyYZ7Jf?=
 =?us-ascii?Q?8SGEogJ5pOLDgHRRIOZg/AHjaVifQPWlRGdxhY5mSerMG1sXQGpNV9k9jYeI?=
 =?us-ascii?Q?rS4JdVsBKBMdRiaUJWYikGI2Qy8D54ivo3PXL8Y8rOmcd84+KWwTFi2sgpTY?=
 =?us-ascii?Q?+gJu8vBS5pB7Mjh3dMsci4KVfRk7UD+uebR/eTccXtuVcfIaDhVUqLiUtmFM?=
 =?us-ascii?Q?+nJSlMC3hEl5hC5DMrDnnPLIJAAHff9kkK/JgJYBjTDOiIhfcqQ8y1hyQrKW?=
 =?us-ascii?Q?W3A1/623oOxExmv5e+Ezk+om8le1y/wYGQz+/C+5QgqAxl47/wvktUwBuf/C?=
 =?us-ascii?Q?hG0xdCvpcVhOlPX52bAh/Ka6LuAGx+XHqwdk6SYMcLerokXm1VsszUn6NCER?=
 =?us-ascii?Q?sZQibxTuna0AUZW33hCN/829XZKE8xWztqSKA91Dgb4NzXpFrCVGsQEQjuFp?=
 =?us-ascii?Q?GQQN4mPBMdKvUunl5fSuSoufTapQRthgYvZgxNUdm+mdg+8fLrWiO81fj845?=
 =?us-ascii?Q?lVEFe+GKwsxryz7HfpdklZk30/RNsF8Q4/UJ6DBmCZsy/ch7ZSu1FHL678rM?=
 =?us-ascii?Q?uFRrqeWCDv1dgCCZFkWZJMhJB4Fck9n7j3xBaX8oXVEny9r+YVVQ9z+qqoT2?=
 =?us-ascii?Q?P7Gdo5nwuuK2eWdPGolPxyuf++IHxrO7NePrG/9C1qZjlC227f3SQgWxb1+p?=
 =?us-ascii?Q?iFB7LN3p+YV4Bnb02F45ebmXeb/OM/c3gEMotFNPtd/qac03K1KbOpONSLwX?=
 =?us-ascii?Q?O9J4a+kczZNqgbQkXBRJsl0rtZuQDROYN5liawMDDDgxdnLT1n1+eg5fYjbA?=
 =?us-ascii?Q?6+BgTe96bALpKz6RhC7ByHWCX5iPPNXBm7kT7sCef7LxLkCwRfEX2SGK75h4?=
 =?us-ascii?Q?cNTy3xevFI8MNTd3glkvURfRsQXbAKsZyegcVuqsDQrVi/gEnDY1j0gYD1UY?=
 =?us-ascii?Q?UyIw6P0X2c/OLq6awetKfnyeg9NvcpSjVB4Iun6h6O3l2rROV6XgOvhk0VP9?=
 =?us-ascii?Q?NK06A7EHGB47DqMUXdAGmEgY13dQeuo7jrFWT1ESffkgFrWLBZtLXyixU0yY?=
 =?us-ascii?Q?xh/0SKtcxXKG2ZnndI0pqL764t7QUhjQvxVLEvYTLFIjBbl1nlsXq0/LPkmx?=
 =?us-ascii?Q?m7/velTIQl87ihQap2cSrUvK+53UqXKLPQc5O9jR2ax1xfIJOUge?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: fb967a29-7a30-4755-a7f8-08de5cadb64e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:37:09.1634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MsIesKUzGDVKZyB8HZxrUP/WmTVWit8EfYM2+urTe/BgVdStof3R1ZjsE8cSIy7s2VYV7EE1s/k41FIF02yURw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6300
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8484-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,valinux.co.jp:email,valinux.co.jp:dkim,valinux.co.jp:mid,synopsys.com:email]
X-Rspamd-Queue-Id: E74C384E54
X-Rspamd-Action: no action

Poll for completion on channels where local done/abort IRQ handling is
disabled (e.g. remote ACK scenarios).

This is useful when a transaction descriptor is prepared and submitted
locally, while irq_mode is configured such that the interrupt
acknowledgment is handled by the peer. Without polling, locally
submitted transactions would never complete and would get stuck.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c | 104 ++++++++++++++++++++++++-----
 drivers/dma/dw-edma/dw-edma-core.h |   4 ++
 2 files changed, 91 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index e006f1fa2ee5..910a4d516c3a 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -6,6 +6,7 @@
  * Author: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
  */
 
+#include <linux/cleanup.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
@@ -312,24 +313,9 @@ static int dw_edma_device_terminate_all(struct dma_chan *dchan)
 		chan->request = EDMA_REQ_STOP;
 	}
 
-	return err;
-}
-
-static void dw_edma_device_issue_pending(struct dma_chan *dchan)
-{
-	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
-	unsigned long flags;
-
-	if (!chan->configured)
-		return;
+	cancel_delayed_work_sync(&chan->poll_work);
 
-	spin_lock_irqsave(&chan->vc.lock, flags);
-	if (vchan_issue_pending(&chan->vc) && chan->request == EDMA_REQ_NONE &&
-	    chan->status == EDMA_ST_IDLE) {
-		chan->status = EDMA_ST_BUSY;
-		dw_edma_start_transfer(chan);
-	}
-	spin_unlock_irqrestore(&chan->vc.lock, flags);
+	return err;
 }
 
 static enum dma_status
@@ -712,6 +698,70 @@ static irqreturn_t dw_edma_interrupt_common(int irq, void *data)
 	return ret;
 }
 
+static void dw_edma_done_arm(struct dw_edma_chan *chan)
+{
+	if (!dw_edma_core_ch_ignore_irq(chan))
+		/* Local side handles IRQs so polling is not needed */
+		return;
+
+	queue_delayed_work(system_wq, &chan->poll_work, 1);
+}
+
+static void dw_edma_chan_poll_done(struct dma_chan *dchan)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	enum dma_status st;
+
+	if (!dw_edma_core_ch_ignore_irq(chan))
+		/* Local side handles IRQs so polling is not needed */
+		return;
+
+	guard(spinlock_irqsave)(&chan->poll_lock);
+
+	if (chan->status != EDMA_ST_BUSY)
+		return;
+
+	st = dw_edma_core_ch_status(chan);
+
+	switch (st) {
+	case DMA_COMPLETE:
+		dw_edma_done_interrupt(chan);
+		if (chan->status == EDMA_ST_BUSY)
+			dw_edma_done_arm(chan);
+		break;
+	case DMA_IN_PROGRESS:
+		dw_edma_done_arm(chan);
+		break;
+	case DMA_ERROR:
+		dw_edma_abort_interrupt(chan);
+		break;
+	default:
+		break;
+	}
+}
+
+static void dw_edma_device_issue_pending(struct dma_chan *dchan)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	unsigned long flags;
+
+	if (!chan->configured)
+		return;
+
+	dw_edma_chan_poll_done(dchan);
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+	if (vchan_issue_pending(&chan->vc) && chan->request == EDMA_REQ_NONE &&
+	    chan->status == EDMA_ST_IDLE) {
+		chan->status = EDMA_ST_BUSY;
+		dw_edma_start_transfer(chan);
+	}
+
+	dw_edma_done_arm(chan);
+
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+}
+
 static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
@@ -739,6 +789,19 @@ static void dw_edma_free_chan_resources(struct dma_chan *dchan)
 	}
 }
 
+static void dw_edma_poll_work(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct dw_edma_chan *chan =
+		container_of(dwork, struct dw_edma_chan, poll_work);
+	struct dma_chan *dchan = &chan->vc.chan;
+
+	if (!chan->configured)
+		return;
+
+	dw_edma_chan_poll_done(dchan);
+}
+
 static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 {
 	struct dw_edma_chip *chip = dw->chip;
@@ -772,6 +835,9 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		chan->status = EDMA_ST_IDLE;
 		chan->irq_mode = DW_EDMA_CH_IRQ_DEFAULT;
 
+		spin_lock_init(&chan->poll_lock);
+		INIT_DELAYED_WORK(&chan->poll_work, dw_edma_poll_work);
+
 		if (chan->dir == EDMA_DIR_WRITE)
 			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
 		else
@@ -1026,6 +1092,10 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 	if (!dw)
 		return -ENODEV;
 
+	/* Poll work can re-arm itself. Disable and drain. */
+	list_for_each_entry(chan, &dw->dma.channels, vc.chan.device_node)
+		disable_delayed_work_sync(&chan->poll_work);
+
 	/* Disable eDMA */
 	dw_edma_core_off(dw);
 
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 0608b9044a08..560a2d2fea86 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -11,6 +11,7 @@
 
 #include <linux/msi.h>
 #include <linux/dma/edma.h>
+#include <linux/workqueue.h>
 
 #include "../virt-dma.h"
 
@@ -83,6 +84,9 @@ struct dw_edma_chan {
 
 	enum dw_edma_ch_irq_mode	irq_mode;
 
+	struct delayed_work		poll_work;
+	spinlock_t			poll_lock;
+
 	enum dw_edma_request		request;
 	enum dw_edma_status		status;
 	u8				configured;
-- 
2.51.0


