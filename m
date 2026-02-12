Return-Path: <dmaengine+bounces-8897-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOQmIVPujWlw8wAAu9opvQ
	(envelope-from <dmaengine+bounces-8897-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 16:14:27 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3BF12ECB7
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 16:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CFBC5300C54F
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 15:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A261373;
	Thu, 12 Feb 2026 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="jNC0lcKV"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021077.outbound.protection.outlook.com [52.101.125.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E152C9D;
	Thu, 12 Feb 2026 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770909261; cv=fail; b=Tf/4i5/JAEne3O7L/euawcj0hUiYDCYeDiCsHm0hhQtCp5BPoFVLV6NIunmRlYUxauwr+2+IQbN7N6ijseBPEoolGmDOwA0hrHwkCyaDlavHiYWltZqF284AtQPhLxT24LJttiqWZt4IRkirlq3NdmhnyAAjxDaXPl9u5tv2Cxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770909261; c=relaxed/simple;
	bh=7wIiuJnH73Q26If4P9WJoDhzEpvsx8mK1pSHuJL+gJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FA/s7ffSQQskqoN2MK9c7QUeMfjyREnls583xymIC1p2cdSD1hm4LdlZRvZqNcUkNCg97TPCmDKaaqNwmj3spgijPpf1Ixb/aSC4rhL5I7cfZVQ5pDkLBqh9FN/XHGI3/znv9lFdoOBxuNLGYAPQ6H02o7MuSkepVofG767Wbi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=jNC0lcKV; arc=fail smtp.client-ip=52.101.125.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ku03wSrABnHieCGxUpKhsrIoZWL3R6ibMl+rbBxXuhmB1wNhbUVkUEiWfNDdN6LrKbyThLn+aeSKReosba3ynHsw6tNq4vjLioYOvadxv91CbPBCfFU+tAO+WrIQKzhsIvseIm4c3zLyVdMe9EQghnwEMCoN+5lXJYB6KqYOT4RJva2iIhGxmRkChJz452HZEyT53f1CcYcmd5uG4jgfNmSOcP7rvLGpaCXwo42a/kIItwyOL+Qxyqf9K/9Gxq/56JGqJSop+MKMKAL96s3UeIvYiPTTB3wCcvktC0Zes6mJxr8yD49J1XEsoOebe7eT48d4kl1o3wrn9q7zardXAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQflI0TtXusYh+dSQtRDBy8LY+4T2ArddPGXaKF8u9U=;
 b=PYGxIXbXTQzAhwzDU9ymZ2mxSBcJ6rjiuiLEnbYgW8MHm3l70Hr5zbWzucs8tbCyyHtKHh0MKxkdQ00dYVwGzOrjCoagtZWbZrx1b14XMyJ3799gM0dDprskiP4EjpQzyFXxmez4WQsJ00dFzIjDaiHor0NfIUnZDZMjGR65Gogt83puOj+oUTMBscssUpGDtdG2sEb9Q8gf4s5v5PSbEDc2Ako9ImXnSYjKyHtEZ3f/BqEGDN8RXTDh+Pv8VhRjHb0itCbFCQYB1Yzrp+fia1Lc+BMFzq3bdnccV2DxNv2S7e/TPY0oEITSHyDcajBeUAmIcddqWR/laKbmySdSzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQflI0TtXusYh+dSQtRDBy8LY+4T2ArddPGXaKF8u9U=;
 b=jNC0lcKVjtAiOXrYsqhspsOi4jxS1pRHi2JiL40OOUXT3bN4OxoKlxEZbjBxNol3qb+iKlvi6g4LGoYXIOQggPGM0WSjT5m2Ado7h5yIlyecBWmQ5tlisMLWZFMj/oY6biiGEex2TpGt8aHa96oOl5CMFZndqITifInhseRWKss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:468::22)
 by TYWP286MB2844.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2fb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Thu, 12 Feb
 2026 15:14:17 +0000
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71]) by OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71%3]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 15:14:17 +0000
Date: Fri, 13 Feb 2026 00:14:15 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: vkoul@kernel.org, mani@kernel.org, Frank.Li@nxp.com, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, kishon@kernel.org, jdmason@kudzu.us, allenbh@gmail.com, 
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, ntb@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: Re: [PATCH v6 0/8] PCI: endpoint: pci-ep-msi: Add embedded doorbell
 fallback
Message-ID: <cf4mpl64e5tms5kw7z33f6cwoarmtmkzykoexoozwamtpz3bvo@q52h7ycdy7mb>
References: <20260209125316.2132589-1-den@valinux.co.jp>
 <aYsjfTtA0EsXwh69@ryzen>
 <2lii3hhzie5n2kkoan7hvittid2bo2jgvkb2fndyscc527xglp@dubt3ie7exdq>
 <aYtdEnZM5mnmcgtY@ryzen>
 <23p74hldtvi2xn6aza2rc6kh5hidzutu46ugzt6mzliyjzylka@k5gchw3amcig>
 <aYyz5WF_iJuNwA35@ryzen>
 <fblyz2hldxgqo2i7fywpgzuaqxzxsbavme7pfahj3uftgloeqq@pxeddjzm4sdj>
 <aY2q80zeRKSRO21H@fedora>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY2q80zeRKSRO21H@fedora>
X-ClientProxiedBy: TYCP286CA0194.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::8) To OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:468::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOP286MB7730:EE_|TYWP286MB2844:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bb0dc4d-c453-4050-867e-08de6a49638d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bF6WsKHt2D3qvSi2iJrw2P0OMHXY9VPgXpUfzfJPOCw9nwqsH4iYOIXWIRWJ?=
 =?us-ascii?Q?UqOV21q3TyUetTJ8g2KzJ+6n1hAu58cHAiiG6XfUhoDyD+Ud5zNeU+T75F1v?=
 =?us-ascii?Q?k4o1f/4IgrxqZ98mddde4uxq/GXE2XHLtGc5JI3kj8CP2uU7CzDU42EcPoc+?=
 =?us-ascii?Q?feMcdGPomVuwVV6s8sZtmO8P3K8C2RfAUBzJxSXGuYtkjblH9ZDSfAY2bBL7?=
 =?us-ascii?Q?u+OfAkj0Z6ZFA3wFJc91dPxFaa5A3y7f8AjIq1QeXhKrf/URLzMzSrAIkDRt?=
 =?us-ascii?Q?jkZY7dmsOe1eFXe/RtCArP3It7hBHXrYCoCUWOOcc2MwhJHMyAOwEMqYmzeP?=
 =?us-ascii?Q?moDLsIR+RPEdoHMSdIt15dphGflqwm3NMWjTtRdH35AH+knqJ+8JN0KgNfdq?=
 =?us-ascii?Q?2PIrCFWF66tdZy+4FqGBNvlrP375MLLnomm4x2ioLh9XBsqSwJnn6dpfF7Bm?=
 =?us-ascii?Q?fiR/ry3wFaK+3IWQqycYdLWRFab5GF8a3XJxcVEC0y/Q7h+rz3/C6iLExA4w?=
 =?us-ascii?Q?QqtItYrRZLxycZHU4TsVtgowG06j3yxO0rlXZtvao8qX2JWUwIZVtbOqZgpI?=
 =?us-ascii?Q?6Td+V8NLZyHMsMFhKeMAjvPLE7fhcQIPIHL3LJh0esWtIWHZn0ImJf6ZLpw9?=
 =?us-ascii?Q?HOLndxTz9eZYahr52yLKVFLnTJeJg6IgpGP4pqqGiN+jnmfYLs80hNSK4ZuG?=
 =?us-ascii?Q?QWmzHresHlUqAC6GPiqCa8UoI2EEA7UPgBjhHdYh13g/4C1ELY3hLy6nYz66?=
 =?us-ascii?Q?T7mItitYF7d+dDYLR++eZvToLuuZwNFzx1rww15WfICyk0OLphe9k2EDs1iz?=
 =?us-ascii?Q?wlv64aa9g5d0JERWpNAad9bMcdGNbCW87QhGjoZg1bduoWthNw0BwhdxS568?=
 =?us-ascii?Q?nEKQtygMVTWGK67CGeQkYWyYCU+fXSAVBwTckp5SOa6ElDMSLUivPkhjg5rx?=
 =?us-ascii?Q?LENyltytQPvvpCLhIdullfxHswSeiFvpIYpzaw62ZxoIKz6bGZjiz83MrnTn?=
 =?us-ascii?Q?0kao8VOysr94EG1pMkws2N/1i+D+Dtfw0TMnsC523Xg30hmE5176JBqE7SDI?=
 =?us-ascii?Q?m4EhTWfM476rea6iFrNuz9APyFb8Krue4WWIOFCJF0DIYI+OlIZyT6YySoZ7?=
 =?us-ascii?Q?03bgZXp4PK0l3PoIAQIukigmLcDHL4a6rzVYM2NwclEbcuzUbCKdZ9MVSDsh?=
 =?us-ascii?Q?GwcSRiGAkUptXQMonm+jy5dJoagSOeTICYDpri2cvNfSthkud9dNegPUbP60?=
 =?us-ascii?Q?KqOYC+QnWcCvPP6yyfP5C6iMf3v+4u9EW2oExn5/OQzgANh76Dtg7WqIh54w?=
 =?us-ascii?Q?8XVH3W6BAtfeusdQPdvf+jlLpsN+Lni5tp3F8siN2HnmtwtpMHHeYv2rI9EZ?=
 =?us-ascii?Q?Drtu8YtEECRlpRWP6/Ml2uwObXY7VQEU8Jovu5hb0un5W1DC3gxGOCcd/q1A?=
 =?us-ascii?Q?el9/75EeIovAQTaiTmkqKno5BUUzpYYTmmxhCEEBqJy5mcAX+KdPNl8gpcnD?=
 =?us-ascii?Q?Y2ReE6AGtBLgcHZ/XgL85I94J57pIgxn8eg8/8ZYfFq4lZZs4rhdNnD2T7ND?=
 =?us-ascii?Q?dWst/ozd9iV8HEqPEmU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wal3tm4CQGwwjFx7UE+fw0ZXoC6Zwm+5h4EMw8pximlbgDva0hZZ72FE8gSI?=
 =?us-ascii?Q?AoO4Z/xwYBshPan8G/n20bSAZmyVk4ZW2BYDwNeUH7F53oUIyDSgtBrjR02W?=
 =?us-ascii?Q?8VOYXWh5DT8wFbb7zwBQfEiPQuZYHdzq2PFn+lgNU8R5WvSvj1zLEMVYphAZ?=
 =?us-ascii?Q?ruiVu9uH6rvBP1mg1HeBbJr8AeiOt/NwOTvBYJm6qb8AprM1grhAXBR5ZPNh?=
 =?us-ascii?Q?u05V7XDvCJ6Xy2TJFkwWPCXE1boUHk/ZwPiL1JoZRDx+xwJ500V4bmm6Zx8L?=
 =?us-ascii?Q?BxOc4BzD8DhEssBMnnE3b9/6fyBoSSYpPtWw4yHgOroq1RqNZl/kvPQrw/I0?=
 =?us-ascii?Q?qHvRFxZsNYr87obCuCoew0X4V/7UFZXPDXE7wjkQQRErIm+xVcEoaG/ZtYqH?=
 =?us-ascii?Q?DGGdWwiZ2TnNts04Aqt/bJVmo4fuG/cDtggQLQuYJ38Ijc17b7CVP2K954NE?=
 =?us-ascii?Q?lgtcG9Edo1N2tspCv+NgSUq2I2zWPCJd/h8/vjXDojhkFbE2JvVgtJSyCGV5?=
 =?us-ascii?Q?siQRHnaNU6H+tJlw37amMYAIME2Pk1/551xWWqhirSwEj5b27uRX4NHXupfS?=
 =?us-ascii?Q?+TDDe3ZlQIaXQoBlrRZPVQ8VHsUCsHgdOkWKTmAlyjMNB6arAM6dk73tjsPP?=
 =?us-ascii?Q?DblSfbm8DdMhDo0czzL/dxvwGgAo5GvLHxawL4UAQKq3u3mlchQ2LpQCIM5f?=
 =?us-ascii?Q?gdIrxLdzaQldNhdUE08my/b19sX7Tde0xxMhzP9UAIHHm0A50Ej1GRNRNxY2?=
 =?us-ascii?Q?nRzSFH1scP05TXqKylQzAUSRoGqN4Jhf4GK1MAN46QyvBrP1DT7zQndsYggI?=
 =?us-ascii?Q?26shovUcDRyOzEoHqWataczp+oPy+lp4Bha6fbipYrVt/iNrJAJdJcS1iAsv?=
 =?us-ascii?Q?zwno3mBbLKgD5ChGz5S3KPkL4T5/s1WVR5TOlrvl1rNuK3ghStTc8UnpovEq?=
 =?us-ascii?Q?Mjj2zL3zypaBRzU2+q+PuW+EMit9McymSBb/YCnFvBabHKFX9WKYS8dcjzl9?=
 =?us-ascii?Q?pMiylehsdwOEJBARn8zcZQe4GraFhY4JfPbFa+WtMtLOOCNnAGDgTCJwCDUb?=
 =?us-ascii?Q?Bs+B2PSP/4mDBODP+iVpmhxQGd+eij//BZSIMJX6xRExml6PpQ/Sp/xwMhDA?=
 =?us-ascii?Q?Zo9yhtZGRx9MIq6D52MdGaVDr3R9eMDbuVriFg4W6loK3B4wSELifG85b5sA?=
 =?us-ascii?Q?1CK8alZ0sVS7wnWFp4H+4gLjkAbi/HTU+3qvT6S1kKIAZyGI26qqQFkrgCBC?=
 =?us-ascii?Q?jLn4euibWF2hZYNVANKNXZoVPQdHl7snodaw9HG3569Ag02DDC0HU9FJDSlG?=
 =?us-ascii?Q?72W27J2rvjimuykON5d0JDhzfejtCscPPs9UXay85MfrtHOFZij9tDDhbevn?=
 =?us-ascii?Q?10lGsRHIagH9Nf+qigDp1mx7g6SsZftyBst5jUSZiF/ZgaLrzJqfDswr3dpj?=
 =?us-ascii?Q?DyG4+5AeIay8YbxvMy14Fei6Rsagp67xFW5+vJ4RG+LdtCE6hn99WsGWNRXJ?=
 =?us-ascii?Q?WwIRKaaeOoibI+fJd9Ufnr2MClgsYj5mrWTqAAmy7JxbvIm+8SmIlol9XaLs?=
 =?us-ascii?Q?j1LITEzvqYRbH2TiDnWvxqp4eQhIzjA5vubFLxLjIvkDlXX1vdB9n6ZDQpjI?=
 =?us-ascii?Q?Zms0+9icLo3aU1ubWRLrc3Z3xGhN2iqNAUYDm/9EypntvKUojoi3F4ahfbbP?=
 =?us-ascii?Q?D1+O1Tz+u6c9Hvu8WkMFEJFEI9ROi9gRHTmQzW6JJw//yC2pTg0ZvMgJj8VN?=
 =?us-ascii?Q?oyXsTqaLC/4oG7gOKIvxBJDs78hVcuvuIqcQCzc++SuU5dB1nW+7?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb0dc4d-c453-4050-867e-08de6a49638d
X-MS-Exchange-CrossTenant-AuthSource: OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 15:14:16.9190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PWD1tXTH43P++sxedIeFD0xtj+tUFxM7Qxkf1Exqv1wK8vvBQF+vDq3uSGJyiO9XpSnvDMF4HFNFySRt2pDDmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2844
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,gmail.com,google.com,kudzu.us,vger.kernel.org,lists.linux.dev,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8897-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8E3BF12ECB7
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 11:26:59AM +0100, Niklas Cassel wrote:
> On Thu, Feb 12, 2026 at 12:26:49PM +0900, Koichiro Den wrote:
> > On Wed, Feb 11, 2026 at 05:52:53PM +0100, Niklas Cassel wrote:
> > 
> > Thanks for the additional context.
> > Even if we introduce the distinction between BAR_RESERVED and BAR_DISABLED,
> > as I understand it, we currently lack a way to describe what actually
> > resides behind a BAR_RESERVED region.
> > 
> > Perhaps extending pci_epc_bar_desc to describe what a reserved BAR
> > contains (e.g. DMA register block) might allow us to handle this in a
> > cleaner and more generic way. It would at least be cleaner than treating it
> > as a quirk and hard-code the reserved BAR+offset+contents.
> 
> Yes, you are absolutely right.
> 
> Improving struct pci_epc_bar_desc to be able give more information about a
> BAR_RESERVED BAR would be a next logical step.
> 
> If we take RK3588 as an example:
> BAR4 offset 0x0 is eDMA registers.
> BAR4 offset 0x2000 is ATU registers.
> BAR4 offset 0x4000 is MSI-X table.
> BAR4 offset 0x5000 is MSI-X PBA.
> 
> 
> Many different SoCs have the MSI-X table in one of the BARs.
> 
> pci-epf-test always puts the MSI-X table in BAR0 (test_reg_bar), after the
> pci_epf_test_reg registers.
> 
> On RK3588, this mostly works fine, e.g. the MSI-X test case in the
> pci_endpoint_test selftest passes with the MSI-X table in BAR0, however,
> e.g. dw_pcie_ep_raise_msix_irq_doorbell() does not work when the MSI-X
> table is in BAR0. If I hack the pci-epf-test code to have the MSI-X table
> in BAR4 (as it is by default), then dw_pcie_ep_raise_msix_irq_doorbell()
> works fine.

Yes, I remember this was discussed in another patch thread.

> 
> This would however require an EPF driver to be able to get an EPC drivers'
> "desired" MSI-X table and MSI-X PBA location, so that it could call
> pci_epc_set_msix() with these "desired" locations.
> 
> 
> I guess we would just need to add a new "get desired MSI-X location" API
> in epc->ops. However, I have been too busy to work on this, so right now it
> is only an idea. (Anyone with some spare cycles are free to implement it.)

While I think the MSI-X table placement issue is not directly relevant to
the eDMA register case (which needs to be addressed in this patch series),
they similarly appear to be consequences of SoC-level integration
decisions.

From that perspective, I feel that extending pci_epc_bar_desc so it can
describe (1) what resides behind a BAR_RESERVED region and (2) whether it
must be reused rather than accessed via a new iATU inbound mapping, would
be a clearer and more generic, extensible solution than adding a dedicated
epc->ops API for each such case.

Anyway, I think that the MSI-X Table case should be handled in another
patch series.

Best regards,
Koichiro

> 
> I know for a fact that many other SoCs with the DWC PCIe EP controller have
> the MSI-X table in one of the BARs by default, so this would also allow
> them to use dw_pcie_ep_raise_msix_irq_doorbell(). (And would also allow us
> to no longer force disable these BAR_RESERVED BARs, as the PCI endpoint
> currently has no way to make use for these BAR_RESERVED BARs.)
> 
> 
> Kind regards,
> Niklas

