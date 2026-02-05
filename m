Return-Path: <dmaengine+bounces-8750-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEKYDIk+hGlU1wMAu9opvQ
	(envelope-from <dmaengine+bounces-8750-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 07:54:01 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D23EF296
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 07:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2ECA2300461A
	for <lists+dmaengine@lfdr.de>; Thu,  5 Feb 2026 06:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D5D352C34;
	Thu,  5 Feb 2026 06:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="jNavelVX"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020091.outbound.protection.outlook.com [52.101.228.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F037E20010C;
	Thu,  5 Feb 2026 06:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274437; cv=fail; b=liaXrHvuhkgEZ8cg0Hlp4KAsOs1vjcxTmvM2iWSzzP6G16VS7zTY9bWv6ji5oK/MllgNw0KBDdQtHVk8o1aQJefsqql++Gp6JtsOU10Oqrlp5e2J0pOSYI4nvUJ5aKywm1FSVQm1/Nd6yqJNoE1g1D5pMuZrwYAn8Us6vMXFGNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274437; c=relaxed/simple;
	bh=gmtfDRzznduIoUeGt50zjZ2kXdUKQ04b0zsuqDJgZPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qtw+58b8gsn9OhGgGi9CxeGLkiNQYddmxRoZtCOGlbOvxOUyKv/ZSauVmmzPXvfLjplxCnCUBeW/wxR1fDZa/u6u7rA6BHppeUlby7MyMiqMeGhTcgYaq1vcVlX+OTlayuwR6Fal0WYNjRQUbEth5Tk3YRAJsjWEWc70G/UCH0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=jNavelVX; arc=fail smtp.client-ip=52.101.228.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Znx1wozlkg0WlEnxkhOA5Ezv+aSJCCd3hQput33nIoY4xm/s3GZq3mhl0W2uTvNmaYXVMRhuw/eUp2RYcNZQBfsjf/CPN9c0qIo/jfxUV9Ot4vDWQP0veXR9iYGw9tggGBY0hKk7n1U3dA34xrp0o/htVsnp2EfX6GPNYPiwKsmUjDMnW4gvX+La0Cw/QgbcInL4EkrD0HcjL2b97uZYvlM05qTnetQF+BHpBGfOtTWXw0WNdn7Y16H6FzGbvvesDBjqp/x6/jQktjdPudGusHTAOr6CxCbp/iCf7c4tR0K/x1P9I/A11ArFKx8aWQYIikR5lngzg7p+5d4hr2Rv3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6vyeIflCzDWFPbHWixcSFFVesZ1m7GCDNJCexgfsKk=;
 b=coyehmaV2m1aiBnHpEtd6fDG6a1pltiVzX5WwL0JlN4iWSCF1KUx24AQCxnjjh3IISCyQTR8M1DrBGSnoJip4ey+QHTt+dhYWb1GRoPV7/HHEiGf7rnzR4qRwbxMrNsITZVOvKLKkkUQDf7cIqodC1MMKq0Y0s2UC+ViyrbgKae2wP00N2KBLypKJApmItXeFIvHkKd/lN70MpV51JnkI1KpnLDcnOcKR/Q2jn6hR676N8VeiU56kB8dMJBiX2T/rXQE8ybLk+xhXSnMzJal53aI5nkb0phIXCOtTuaHtvn2At1TnIZJV3bv9ISnMqycTFimJ3dkhaddR8oqzQ9/nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6vyeIflCzDWFPbHWixcSFFVesZ1m7GCDNJCexgfsKk=;
 b=jNavelVXmlpEiIvol3lnTEUVYX8Q7VbKgk4sHrtql+UQmb1HpI2Vu3sP+wHaGPgiin32nQMM6MM8lzRPCJU/jXqs3ObotuMWsI1GmHJ72tZRM605qKfnnlkcvlWYJmNXyRSBhqFhwHvuTHloxdrWBaJ+6beMZzPonx79zA5Vmhs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5381.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:191::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 06:53:53 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 06:53:53 +0000
Date: Thu, 5 Feb 2026 15:53:52 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: vkoul@kernel.org, mani@kernel.org, jingoohan1@gmail.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/11] PCI: endpoint: Add remote resource query API
Message-ID: <dmbz4qealzaiqvmmb4fcvsnkymmcm4qoxn5lsp2h4jal4cpmsv@hdfyd7evbr74>
References: <20260204145440.950609-1-den@valinux.co.jp>
 <20260204145440.950609-7-den@valinux.co.jp>
 <aYOILtPYxazppfRD@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYOILtPYxazppfRD@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY4P286CA0082.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5381:EE_
X-MS-Office365-Filtering-Correlation-Id: a7dc7285-77d6-460b-a30f-08de64835355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qq0BZonwDjnj7q4+2MyPAy1cPQ8WDtxPQ5IgsoBVYgVcOlU/Lcxc03RdnPFU?=
 =?us-ascii?Q?hNoBqBfQMPT1HLT9JmpWvvLC4J21gD28azdtcyboPTQvW1OmG01K4GNQAkvE?=
 =?us-ascii?Q?qK+DZ5vUtscWx1lV8UDyHXfr4Xdl60/v7i9mv0XIEXgypuv63pheYW2sXz/u?=
 =?us-ascii?Q?rzSo1/QKU8wetc60OjjAyvzJgEXYYioU1UP+2wf3U5YjFgfHZvvP1gn1IoVl?=
 =?us-ascii?Q?c7fXJrgIs+uj1x5blOnirojR3gL2bncLVYtj457w6ounIlEsngd+nqre7yP7?=
 =?us-ascii?Q?vW+QEcZGk0nKJKu43s3pTHmpw8xorTLl6fr5QCVOD8rIU33mpXzcgKP7au3x?=
 =?us-ascii?Q?gK2BDB0DXI9v/MoOvkSVALbdTFUcmWBe5mK/8R/JTqAdt+9cfTRi8Q8j42dz?=
 =?us-ascii?Q?50zjsx5p1mDifzYM3AQxBr0fa78u5GFHwrZa5FW4n2P5xARjn6gqzWx4tB9f?=
 =?us-ascii?Q?bOllqYIv5GcgV7d3nayqBptdQ15TMrOnju0D7D9M+GUw15iygI5sDwXIDI2X?=
 =?us-ascii?Q?q+6I9ZpxKMKB9GPOeEV08/ks7W4fjyfhIHfJvtjADroEVp5SZvn9j36qW4hl?=
 =?us-ascii?Q?ejiR8+1zYDzTfsZFEhDCUT6jnUqQl/vFKGpHs84OGSO2eANqAp72hhUQOYRV?=
 =?us-ascii?Q?2ws/g6FUNg/C1IcU/g6ZYq7zgATvBNgg2Q1PGVpjD9uPa+gyZglZBmY6JH7B?=
 =?us-ascii?Q?OniV1FbNluVQYxpqQI2Ydo8mTDK7div1TzgGs1y8AmGBMj8znrCIXU7dmmGc?=
 =?us-ascii?Q?8OilXDCZgJ6CNHXZ0NcYM8DovbpkSnIIBa2p/pFrI42ZOCIvHKVaerJ/qQNz?=
 =?us-ascii?Q?bmTjunr1TZkHnJpHAMe/6k5grlArX/L2Ze/eyQ+XolNA653wN5OQbIX1cY01?=
 =?us-ascii?Q?+pbMgR0Sp2DbBVuFIKBqSTdA8dKV29Cr4+C8xaMxm/QuNDV0hhX9McSIThT3?=
 =?us-ascii?Q?HV6Ezjq3iaNz12Qe1OwsMTwQDbAmXWx/17aEeHk6VtWkrcn90bbGHI5b6fK7?=
 =?us-ascii?Q?xdreF1UoKdjryBdN1u17kBrVddCb5SDTdBZYcHazgObYLLP3n5XurRZrotbL?=
 =?us-ascii?Q?dPUd2QIj70MoyPIGaJQR5O9IGVTHkTPJdgxMtOUJGgK6cvKuZ2MmHFD02g6x?=
 =?us-ascii?Q?5XKuM9SZ1BVbYRLRdec7vvPO+oh1EIlba9mBU4y+ofsYOYCqrd6MGclMZrmH?=
 =?us-ascii?Q?qMiNDBUVLGGUh17l55kdXhpGFErYbdhYYguDXnzYnwVxVoxzmkrh5nGb0K8k?=
 =?us-ascii?Q?j/SdM/Y0msEoHktPQhfrgkODS1010zef+TIv4k49UyWLWEzgCVBjru2brcpJ?=
 =?us-ascii?Q?XCBH6vJVcgUtPJGvyqRayQjIQohQhh/8Mr8UNrTEDjDYlK59TP/culMxvE+4?=
 =?us-ascii?Q?b8o98OzZSWwg6iYyPLlsgl6y/rvh2Gpg0QWUiiyLorokPzJYJgyMCUsfYVOB?=
 =?us-ascii?Q?k+dHMOnIVHrv0/7lr+hShHNGgQjXPrNhTfFevEhyNrPz5Okyfy1N4W9ZHlh4?=
 =?us-ascii?Q?P5W0pltEbrEXLJkQtcatMhjwbilo/zuwMgEUUSRcSe1gki+yLTs9ez814PtJ?=
 =?us-ascii?Q?DqxKcurEbsD/myxqHcQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XeZvewUciyFJK2wmTV2lQZIIr214ZfRQ2IU2h6gEzT+9wLdliFGsdRuQNwBx?=
 =?us-ascii?Q?MAn2gEYsDuwgBLZdMCeMZqCfKXiJiOIGCfVgd4TFS0uZ/aDRLR1JNjMLaGYc?=
 =?us-ascii?Q?rZiCrgLZoJg8AtoNBWjJasdlCjJzklvtoxFePJRV/wPXW6OXp+HWSogYAQgZ?=
 =?us-ascii?Q?PRG+fuTL8D64jvLsQWOPb9x1P4aLatTywYSdi2vPckD9hkSXiqfohbMcK7ym?=
 =?us-ascii?Q?pRLVVMJ0BRAqyvQq+cDfCb5pFn2mGtYa8f1oC6ZVs5a+/Qcqxe8MwW+k49e1?=
 =?us-ascii?Q?Xcv8fytH+D1F30OGOUSjbc0YQKHLMgrVQyYgGfdPtidRzFqISWG/XgE0rlEk?=
 =?us-ascii?Q?bsY/Hqc7JeHuwIbHPMZVRUJAVoxgCohOIeOaAxvlXdsBmvTXpjgk3rCAm7jc?=
 =?us-ascii?Q?nu9L8Ja149ri47QRawMtHu5ig/q4jwL7+y9y8nbOpA/SLmjEZwf8997r4u3c?=
 =?us-ascii?Q?iyn1vjBvrlV+gKa8ifz8NjNHEi7nU7AtHkI8BXFzZ7g1jDdnFt60iC1FyI9n?=
 =?us-ascii?Q?9acWNWIyf64Hupx/GEHFc2Gv60Yposc1/dHRI011knhsDbYqPQvhje315lSs?=
 =?us-ascii?Q?QMSbyjDsScxXd79dpftIl2dQ+9yKssevpCrqEIR+2RpUJE0JpaD1WoDtr26t?=
 =?us-ascii?Q?58oiJYKu/zTPejZHi0x6oYFscR3gAGjztQCpISZO8fTwDQKxNkXpVkpG0/9i?=
 =?us-ascii?Q?G0jF6z4iXknW0YVzTs9icZ6rcIqOdCQ5GmEG0wkLy0xRFgRuHc1vmZpiijWg?=
 =?us-ascii?Q?XOfh489LngF5mp3DH2h6/50YouyISDM9KezjyC/sx+i/4GHErGYXRbrxt00m?=
 =?us-ascii?Q?GybTgdWqfC3UmgwsY1t7frGNNq++88sdpJJco+3QW5eG5tJoqipEKmbOzqK6?=
 =?us-ascii?Q?TEeQ/6VM1IPCq7CsL3M/w8Ocr2A+kDwvZjGM+onwpkd0uPoN2mbgxFgO479r?=
 =?us-ascii?Q?lGM1UlULgtdPB4M5s1HiYzNBty0tY3uk8hRXUhTRQAyYgXTpGj7ZIioforL1?=
 =?us-ascii?Q?MvDRGd/8p28tXFD/L0Zdq9HMlBD709oPuUJati6qrqZV0S2hrK102VX1jPRM?=
 =?us-ascii?Q?ux50mrD3Mv4qwRgpRakEj20kc6XSDyWWSu86wx4kHr+DuzTUTAMWs8MNmltT?=
 =?us-ascii?Q?3NCjET7GRMTmwaO2ECSRQlBsfVqYMD5phonIQyqkceWgxlfDgdyZ5Wxmm5Ga?=
 =?us-ascii?Q?jeY05C/424EfBvDNVWF4ij7ENo7n2RJ6Z3zA9XmXuh/0Pk54w+LaIvDuZdxt?=
 =?us-ascii?Q?5XSQ8Eo1D98XrOXnqFLUmIvdEEdLLSpGj6fcZO+tyAsenSMCDqgvRk/ks5U3?=
 =?us-ascii?Q?V/z/Kxcm+v7m/Vpb4DTvxVFwzqirKhTpJkw11ykKcMs99wZ9rP2QO7+uEoAA?=
 =?us-ascii?Q?W/pZM0p7EzFz3QVLA2oELP+reeTufZMOYM6DVH5sBEKLCwnGmKs4O4dQislo?=
 =?us-ascii?Q?y5YdeSUYoFTkmXHRImi/8B0A/gDJCfxGb6K1owCvHKCK57uQ01tBg1v7faAv?=
 =?us-ascii?Q?S0XYNMfuQAJ585w8CdHijcCG0KE8XaG9hClp4UmB7RdsgWynlNWDJsIafC/f?=
 =?us-ascii?Q?v6cgDioGyIe2zCQbyKAFpcZRSNXGNAndihO5bPBjlVUxRCydCUaPcOcck+YH?=
 =?us-ascii?Q?vunXnGaoCqpojYBZhSsn3wmJvvhQgdcnXCeSl9Izz3P3qug7wtXNOz1HBHvN?=
 =?us-ascii?Q?v7nys/SKolNyJ92388P8udAmcAIaB7rsOhJV9J6VZpRdNZAiOZt4nN7FyjQX?=
 =?us-ascii?Q?ajYgGkJlIRPbs6n+X5uXycQJlJlrKqRHJrSbiArrHr7x7e/79Q2J?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a7dc7285-77d6-460b-a30f-08de64835355
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 06:53:53.5345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjHwjC+6Bd64ONtjQhy+kZeJWZgBbjoxj5n117Z/3nHTzCldApJzQTz5yI1w0jzyzhaTH7YHx59wjhl9/+mNyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5381
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8750-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4D23EF296
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 12:55:58PM -0500, Frank Li wrote:
> On Wed, Feb 04, 2026 at 11:54:34PM +0900, Koichiro Den wrote:
> > Endpoint controller drivers may integrate auxiliary blocks (e.g. DMA
> > engines) whose register windows and descriptor memories metadata need to
> > be exposed to a remote peer. Endpoint function drivers need a generic
> > way to discover such resources without hard-coding controller-specific
> > helpers.
> >
> > Add pci_epc_get_remote_resources() and the corresponding pci_epc_ops
> > get_remote_resources() callback. The API returns a list of resources
> > described by type, physical address and size, plus type-specific
> > metadata.
> >
> > Passing resources == NULL (or num_resources == 0) returns the required
> > number of entries.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/pci/endpoint/pci-epc-core.c | 41 +++++++++++++++++++++++++
> >  include/linux/pci-epc.h             | 46 +++++++++++++++++++++++++++++
> >  2 files changed, 87 insertions(+)
> >
> > diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> > index 068155819c57..fa161113e24c 100644
> > --- a/drivers/pci/endpoint/pci-epc-core.c
> > +++ b/drivers/pci/endpoint/pci-epc-core.c
> > @@ -155,6 +155,47 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epc_get_features);
> >
> > +/**
> > + * pci_epc_get_remote_resources() - query EPC-provided remote resources
> > + * @epc: EPC device
> > + * @func_no: function number
> > + * @vfunc_no: virtual function number
> > + * @resources: output array (may be NULL to query required count)
> > + * @num_resources: size of @resources array in entries (0 when querying count)
> > + *
> > + * Some EPC backends integrate auxiliary blocks (e.g. DMA engines) whose control
> > + * registers and/or descriptor memories can be exposed to the host by mapping
> > + * them into BAR space. This helper queries the backend for such resources.
> > + *
> > + * Return:
> > + *   * >= 0: number of resources returned (or required, if @resources is NULL)
> > + *   * -EOPNOTSUPP: backend does not support remote resource queries
> > + *   * other -errno on failure
> > + */
> > +int pci_epc_get_remote_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > +				 struct pci_epc_remote_resource *resources,
> > +				 int num_resources)
> > +{
> > +	int ret;
> > +
> > +	if (!epc || !epc->ops)
> > +		return -EINVAL;
> > +
> > +	if (func_no >= epc->max_functions)
> > +		return -EINVAL;
> > +
> > +	if (!epc->ops->get_remote_resources)
> > +		return -EOPNOTSUPP;
> > +
> > +	mutex_lock(&epc->lock);
> > +	ret = epc->ops->get_remote_resources(epc, func_no, vfunc_no,
> > +					     resources, num_resources);
> > +	mutex_unlock(&epc->lock);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_epc_get_remote_resources);
> > +
> >  /**
> >   * pci_epc_stop() - stop the PCI link
> >   * @epc: the link of the EPC device that has to be stopped
> > diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> > index c021c7af175f..af60d4ad2f0e 100644
> > --- a/include/linux/pci-epc.h
> > +++ b/include/linux/pci-epc.h
> > @@ -61,6 +61,44 @@ struct pci_epc_map {
> >  	void __iomem	*virt_addr;
> >  };
> >
> > +/**
> > + * enum pci_epc_remote_resource_type - remote resource type identifiers
> > + * @PCI_EPC_RR_DMA_CTRL_MMIO: Integrated DMA controller register window (MMIO)
> > + * @PCI_EPC_RR_DMA_CHAN_DESC: Per-channel DMA descriptor
> > + *
> > + * EPC backends may expose auxiliary blocks (e.g. DMA engines) by mapping their
> > + * register windows and descriptor memories into BAR space. This enum
> > + * identifies the type of each exposable resource.
> > + */
> > +enum pci_epc_remote_resource_type {
> > +	PCI_EPC_RR_DMA_CTRL_MMIO,
> > +	PCI_EPC_RR_DMA_CHAN_DESC,
> > +};
> > +
> > +/**
> > + * struct pci_epc_remote_resource - a physical resource that can be exposed
> > + * @type:      resource type, see enum pci_epc_remote_resource_type
> > + * @phys_addr: physical base address of the resource
> > + * @size:      size of the resource in bytes
> > + * @u:         type-specific metadata
> > + *
> > + * For @PCI_EPC_RR_DMA_CHAN_DESC, @u.dma_chan_desc provides per-channel
> > + * information.
> > + */
> > +struct pci_epc_remote_resource {
> > +	enum pci_epc_remote_resource_type type;
> > +	phys_addr_t phys_addr;
> > +	resource_size_t size;
> 
> is it good use struct resource?

Personally I don't think it's the best fit here, since these remote
resources are not meant to participate in the global resource tree or
managed by the resource management framework. And most of struct resource
fields (name/flags and the links) does not make sense in this context.

> 
> > +
> > +	union {
> > +		/* PCI_EPC_RR_DMA_CHAN_DESC */
> > +		struct {
> > +			u16 hw_chan_id;
> > +			bool ep2rc;
> > +		} dma_chan_desc;
> > +	} u;
> > +};
> > +
> >  /**
> >   * struct pci_epc_ops - set of function pointers for performing EPC operations
> >   * @write_header: ops to populate configuration space header
> > @@ -84,6 +122,8 @@ struct pci_epc_map {
> >   * @start: ops to start the PCI link
> >   * @stop: ops to stop the PCI link
> >   * @get_features: ops to get the features supported by the EPC
> > + * @get_remote_resources: ops to retrieve controller-owned resources that can be
> > + *			  exposed to the remote host (optional)
> 
> Add comments, must set 'type' of pci_epc_remote_resource.

Would something like the following address your concern?

    * @get_remote_resources: ops to retrieve controller-owned resources that can be
    *                        exposed to the remote host (optional)
  + *                        The callback fills @resources (up to @num_resources entries)
  + *                        and returns the number of valid entries. Each returned entry
  + *                        must have @type set (which selects the valid union member in @u)
  + *                        and provide valid @phys_addr/@size.

Thanks for the review,
Koichiro

> 
> Over all it is good.
> 
> Frank
> >   * @owner: the module owner containing the ops
> >   */
> >  struct pci_epc_ops {
> > @@ -115,6 +155,9 @@ struct pci_epc_ops {
> >  	void	(*stop)(struct pci_epc *epc);
> >  	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
> >  						       u8 func_no, u8 vfunc_no);
> > +	int	(*get_remote_resources)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > +					struct pci_epc_remote_resource *resources,
> > +					int num_resources);
> >  	struct module *owner;
> >  };
> >
> > @@ -309,6 +352,9 @@ int pci_epc_start(struct pci_epc *epc);
> >  void pci_epc_stop(struct pci_epc *epc);
> >  const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
> >  						    u8 func_no, u8 vfunc_no);
> > +int pci_epc_get_remote_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > +				 struct pci_epc_remote_resource *resources,
> > +				 int num_resources);
> >  enum pci_barno
> >  pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
> >  enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
> > --
> > 2.51.0
> >

