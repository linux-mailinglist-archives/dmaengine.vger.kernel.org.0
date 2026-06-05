Return-Path: <dmaengine+bounces-11190-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WokSBzgUI2o4hwEAu9opvQ
	(envelope-from <dmaengine+bounces-11190-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 20:23:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 951E864A91F
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 20:23:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=BJNm0rMU;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11190-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11190-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACD5930E7A3F
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2026 18:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A333A7D74;
	Fri,  5 Jun 2026 18:16:02 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012042.outbound.protection.outlook.com [52.101.66.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B865F3A783B;
	Fri,  5 Jun 2026 18:16:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683362; cv=fail; b=tLyW0UenlzJSjZ7LjuOIms5evRC+Cnh2hqiYgVNcRHF3+2mtj+rM8Mh1RGXtnpYJtyA6EeCNkxBm3rBvxDtqY86SMHG2vEnMtoFC21Cw1wtKDZfGJMXaf+OeuVy/Tzb3Mk2K3i+8FxsfCRG2ScLvDBS42HqpWBrnKyFwCSJFAY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683362; c=relaxed/simple;
	bh=PVjIcxw8qQlrrieCA2B34nsGe/a3resOY/Qgy3d8HaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DFVhyJszObdKF4Eg6cLEVXKvjX/9y9H6SBjDK843oVaGqAEf4P4gY5tZxM6PiZR6Gj3XuWqRDAsrivzuzV7MVtd82fbKbU1IGoGAOEmuCUw65THKio/b8Nd6p/+6tebV26kzjCL7XLbs9HbpqcZPJnepAkXNOmMyH9NhH7ivOUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BJNm0rMU; arc=fail smtp.client-ip=52.101.66.42
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4u9KQNuIsGq+qCltqbqaEbpPMIPknhGzA6799yHL1AXlrAhKd1j6OVGlH/N1K9SQwi4orVDp8YiI+5E6G3cTNvJJWDGSmcuFHjSSSrnPuvGIu4kjI9xGkA9+1QT4PrqlQQ0JnqDLYMCVKRPdfy3TONvkFli9s6H0fPdGHpQdENDhbkfwyIExWenW5uzq2WRtlbU06YH5mheMcz9HFS+7q/sKjJ8Qn9kUVuI7LgsaoR1axOy2xAc/UPnc0AmqwIj2yJ78H/Mxyw8+nzo52wZhMGwhjUyQxrp22qUdR5W+WpM0xs/OTbt2vKUGvMOx8w2uHmKQ2AmXcdM5jha9hsHOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFjGT1bO9aPh7kJf0g0EJ+sEaqCXSFK84d+Wj4ckPDg=;
 b=sXFcC0grH9ffIOFME6QInZQRjv/a92sSAJ7YFTuk+ynzdQ4zx3or4T9cmH/tBqO97N3y08Jz+h/gpJMkHhmzyM5QABivMCIW0qiLmJgLoKco/VHH40XcZifnGaUw3O8Fybs825rOVo5qtkXlhd1TNzQt2KfdkDKtqrKAuDshCNO+Lk8H696/6bW+WrelhWUek7Rtq7hOyzb1k7nleoTwurFCs9sGgOGVHOorAhQ7BtP54qlhCJZpgQvX0qOO2jA7u/OkreuDbERKZhFtG+Jx2JuVzDqsIk/X5CURjecrFJvBofaw/juei8TJr6thBlB9zb66MK0VYxsUMiRupA8/2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFjGT1bO9aPh7kJf0g0EJ+sEaqCXSFK84d+Wj4ckPDg=;
 b=BJNm0rMUzaAc8NVYSeGknb6lxQncB7m+jt3s60rCNTG1/Dp9u8RBIoFxNZOXsgZqVZCV1SJoX2kOZlGZtGdioiHQo0z5YdU9ojbbn+e8uUZSy9/qV4jrQQCMvi4NKAJ0s3ME8KAY1dklqYWZ7772OhP2CZhaLPluFFFnZRl5Mc4c8TFiqs4O/BdpfiUEeixmKxGuuWUdVEY2mW0hfMNa7RD5Q+sB6yFHM3HOEZeoO/Ptn2HXluLQpR05VwqFnaFU73PYEv2DhW4zLO0pW5IGigeCCPciqhH2zgMzoD+/c/LlKi0eissgSrxfqcFLNZ01CpAlBFeq2X6VdGzPI7YAGg==
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by AS8PR04MB7991.eurprd04.prod.outlook.com (2603:10a6:20b:289::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 18:15:57 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%5]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 18:15:57 +0000
Date: Fri, 5 Jun 2026 14:15:41 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Verma, Devendra" <Devendra.Verma@amd.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"mani@kernel.org" <mani@kernel.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>,
	"Frank.Li@kernel.org" <Frank.Li@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>
Subject: Re: [PATCH v3] dmaengine: dw-edma: Enable HDMA 64R/W Channels
Message-ID: <aiMSTaRe1sBhojaw@lizhi-Precision-Tower-5810>
References: <20260603144147.3249691-1-devendra.verma@amd.com>
 <aiHY5V937ygrQ7Zt@lizhi-Precision-Tower-5810>
 <BL4PR12MB94822DC255780FF60297532595112@BL4PR12MB9482.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL4PR12MB94822DC255780FF60297532595112@BL4PR12MB9482.namprd12.prod.outlook.com>
X-ClientProxiedBy: PH0P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::20) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|AS8PR04MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 986d0136-085b-4bc7-21fe-08dec32e79fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|19092799006|366016|38350700014|56012099006|11063799006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	fVqQWA7PDZdEt0lLpDbwaz5Q+KsX5VSW/B6sHgBvnJ/30fimpmuYSmR9fENM1O8KFBnkYzXXxpzPQogb0kt2WN6G1NTowvzlCUy+O2WxOjZUZPRgoqPyftkXSW4nMWvTwmMgg2L1j6WD7JqJ3QGxu/qF0C1vSZ/12FIRoOLhlBHR8MnIhUrz9kxBeZbao+qAj6qodsVQxylYfEKMUH2pxee8BCI2lRZ0mmhg5hVFFgrTvM+bGFMhlMswfGAKN34B/2wp/QvaCHf1AtOHPOjIebEdJR68hOqzdAcJeebDN6r2e4EmHu7A33ZnFg5edoRDbkc3KT/KDg25AiSdKl+L2ZRBzJJk7IWcwGc/uB0KjTks+Uoc9SzX9tkxJZ0OSNEQRq1tAtH99Q1u911rxYh9BEgDD9THEjPo7TMUi8uhn1JSi/ska7siDf6PEFj6Jg2t0ZyEWm4frUsRIVbnKwvmkhdRlUYbFglO7KncT49ydo3023ntFyZgvrG8Mgy8e6/FRQ1AR7aF7amgsfS0wYH8FH0yoDgGOHGQudWkvdv2N27vc3Bmh6iwcE9odQrlhhS0MJCg4KF3tLijYHudstLKNo/oqELqBk5RNf1RhrTUgm4hkHGo8WAMdcoCwFVwDmGES/6DC/aozKJdd4YfX5laVPKFyVcr5+X/ehx2N2DrY4xc4qQMkpD+aLwGPpz4x1/ow5dA7nUeUEf0zZcqpK5z/aHDtN6/cFQCXXWV7kp7UsUlTO0BAd7lcI5zFmpzOpiJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(19092799006)(366016)(38350700014)(56012099006)(11063799006)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8AJDFhCn4UnlSJxAEHHAbQA8s1ogQtVVeg5P8K8BBPnzkCtQipRmStmXC/kk?=
 =?us-ascii?Q?TLi2UOE07uVMpnSHB6R/soBAzCC0KQPsR7BBbahVjKLrFvcSEn2eB9WGSBvx?=
 =?us-ascii?Q?1ImwbZVU8MGxS9hQ8R6QSSi+uoa0ckfXcMmfkYVXLfBiPkXgwj8vYRiUzIbj?=
 =?us-ascii?Q?4LwYT3MHONaduR9oRKUEDYZE1DdeV2NvD1ixd0Z8ytHv/+2AnKnPiJW/52Wk?=
 =?us-ascii?Q?JHcuAlTCSemt2HAZIhbnPH9qOjVKN2zuEabWkfhebErMIFVPZJeNu3RwQILG?=
 =?us-ascii?Q?Fwt3588VcsZ5Hv8Yw1fJFShh3+wn56hpX8T9lgITUd+7DdYL8q+F19m0I1Cm?=
 =?us-ascii?Q?yM+YCqMIql8iEqUmBGXxnhOaJsfpEOu3eV6fv/cl5sm7Wb6L2g2AGbMh0m96?=
 =?us-ascii?Q?QJ4JOtVWzmtfuDNe3GFWVSYHtGKVDdaPc84fxbYjhnj88pfKQUU6mupJ4k/L?=
 =?us-ascii?Q?ji2GtMtdUWfOrbZt4OCODYsp/FhkI7fFDijBNbFTkk9m94fPzkYpJJ/46Fj1?=
 =?us-ascii?Q?2/3zi7iBUNBftlcVeJH1bHZAnZkucd3wtYMIRgk5VX79Emdv9QToLciNVWyG?=
 =?us-ascii?Q?x8ZYCKk7tPDPUOzaTGzCVXagYVDqzF2FaGdQ4L3/dBUBWBjl/abVpzTDNpzh?=
 =?us-ascii?Q?alV1zbLCnRDey2j6zQCkIAy9QmjPig3o9jcF3q3TtM6Aazam9m2+1MwiuCEM?=
 =?us-ascii?Q?IdlOcBlIOlsUhlkPyNz9Mjf3Mb7mK6el0QeGBXwW1VAhH1VhnWKBdMDNfR1W?=
 =?us-ascii?Q?5fMw7wyGhigjkNHFOO5VyvzR6/auLCZeEwFJdNhGOsTZ0YU9iiir+kSs1p9b?=
 =?us-ascii?Q?qyRmeLpWQt54MQ/qJB7NoaAuAucKvjwelowI2Lvlo6lTepBGaBC/u1YDQCK5?=
 =?us-ascii?Q?+A3tPEsNr2RruvuWkLaPeW0hkSosgfVbb5mpr2EA5gfLK6OymMHOAZnqxBKP?=
 =?us-ascii?Q?oiKoMjzVKvPJ9X2Nuj6E2CrGwoB49vSZCVp2CSthKB2lEBNgJbzzAj0laww+?=
 =?us-ascii?Q?j8PaV+bmHXFiHbbx3RrAO17ShaufOuKl0d703L+IX3jbTFq6gqSwxLmNbWr9?=
 =?us-ascii?Q?PkLmzz7Fyn+HNidPo5RME4duX4n64Y9ZWYh36tVtVInmIxMNYccbxuk9l/7q?=
 =?us-ascii?Q?gFouDuAWgLP54rTo9+DozqKZdWt3h7FItOFOk0rgFfUbI9wLGraBhkkVIlTb?=
 =?us-ascii?Q?F1wM9ZAaNuoUAypzFRjebrOhnSiBRA7ZUVsYVlDoFpx2zlOl/QqpD1MhU7tF?=
 =?us-ascii?Q?4AVxuveccxTnfzs2TtcV1+mOP056jwfC6wKhRVNuGIHHCgtnmfUOPacZVS8n?=
 =?us-ascii?Q?J3Ddg2UMkcnAeIIyM+WBQnkOijXqbWoeCYib9cKmJSh5iLYE1/ws1ujE79tc?=
 =?us-ascii?Q?A0bpUCzDFRSZu5UV/IQKYwsM7dx6aVn7yMkq+R4ymRa5QrQCo7+GbAnCS1X7?=
 =?us-ascii?Q?gqHjdOayUEVhMOQCPAQVYLS3eejyVeyHHDOxipTjtQo7HIHuLS/Wc7djB4SR?=
 =?us-ascii?Q?ePV82MCXQp33KRBi0hCVmNGZrLnjhYamoDIXI0wtupvyFDnSDjgM7SZnKUJU?=
 =?us-ascii?Q?iMQ93/bbaDZmDW8Gh3Tvxh9C6y7ghIM0CccqgME7d1Y+EugiA8+0V8gkQIep?=
 =?us-ascii?Q?e32XuA2dLLKpuhFi7Qmhe6aiA6bHM3ALcJ5O4sztdYtajgdatyTDnDB447+4?=
 =?us-ascii?Q?qBvtGI80L9w0VAvY1eOvhFCitBz+1uC81KjVvZihUwCA8bVxZHcIz5seJK5W?=
 =?us-ascii?Q?FC1dDm9vYg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 986d0136-085b-4bc7-21fe-08dec32e79fd
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 18:15:57.6885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8QVAFpLXD3D811lMaKirct8bpyX4QHTj7jVmDvMLJfZmU/+xVvFbqqVC2bWEWvIAGzc3eR7XEe/61iDzmB/aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7991
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11190-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:Devendra.Verma@amd.com,m:bhelgaas@google.com,m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michal.simek@amd.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:from_mime,nxp.com:email,lizhi-Precision-Tower-5810:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 951E864A91F

On Fri, Jun 05, 2026 at 11:48:05AM +0000, Verma, Devendra wrote:
> Public
>
> > -----Original Message-----
> > From: Frank Li <Frank.li@nxp.com>
> > Sent: Friday, June 5, 2026 01:28
> > To: Verma, Devendra <Devendra.Verma@amd.com>
> > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > Frank.Li@kernel.org; dmaengine@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > Subject: Re: [PATCH v3] dmaengine: dw-edma: Enable HDMA 64R/W
> > Channels
> >
> > On Wed, Jun 03, 2026 at 08:11:47PM +0530, Devendra K Verma wrote:
> > > As per 'Designware Cores PCI Express Controller Databook', Section 7.1
> > > - Overview, HDMA supports 64 Read and 64 Write channels. Current
> > > controller driver supports up to 8 read and write channels only. In
> > > order to utilize all the channels the controller driver need to have
> > > the channel related structs and variables as per the number of
> > > channels supported by IP.
> > > Following changes are made to enable 64 Read / 64 Write channel
> > > support:
> > >
> > >  o Defined HDMA specific macros to reflect the channel count.
> > >  o The count of ll_regions and dt_regions in dw_edma_chip and
> > >    dw_edma_pcie_data shall be in accordance to number of read
> > >    and write channels.
> > >  o In dw_edma_probe() configure the channels as per the channels
> > >    of the IP used.
> > >  o Changed mask types to u64 for higher channel counts.
> > >
> > > Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> > > ---
> > > Changes in v2:
> > >   o Fixed the pre-existing bug related to GET_CH_32
> > >     interchanging the channel direction and id.
> > >     This bug was not caused by any version of this patch.
> > >   o Fixed the issue when using for_each_set_bit() for mask
> > >     of u64 type.
> > >
> > > Changes in v1:
> > >   o On review recommendation of sashiko bot, in the function
> > >     dw_hdma_v0_core_off(), the loop iterates over registers
> > >     as per the number of channels enabled and not on total
> > >     number of channels supported.
> > >   o Changed mask types to u64 for higher channel counts.
> > > ---
> > ...
> > > +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > @@ -53,13 +53,24 @@ __dw_ch_regs(struct dw_edma *dw, enum
> > dw_edma_dir
> > > dir, u16 ch)  static void dw_hdma_v0_core_off(struct dw_edma *dw)  {
> > >     int id;
> > > +   enum dw_edma_dir dir;
> > > +
> > > +   dir = EDMA_DIR_WRITE;
> > > +   for (id = 0; id < dw->wr_ch_cnt; id++) {
> > > +           SET_CH_32(dw, dir, id, int_setup,
> > > +                     HDMA_V0_STOP_INT_MASK |
> > HDMA_V0_ABORT_INT_MASK);
> > > +           SET_CH_32(dw, dir, id, int_clear,
> > > +                     HDMA_V0_STOP_INT_MASK |
> > HDMA_V0_ABORT_INT_MASK);
> > > +           SET_CH_32(dw, dir, id, ch_en, 0);
> > > +   }
> > >
> > > -   for (id = 0; id < HDMA_V0_MAX_NR_CH; id++) {
> > > -           SET_BOTH_CH_32(dw, id, int_setup,
> > > -                          HDMA_V0_STOP_INT_MASK |
> > HDMA_V0_ABORT_INT_MASK);
> > > -           SET_BOTH_CH_32(dw, id, int_clear,
> > > -                          HDMA_V0_STOP_INT_MASK |
> > HDMA_V0_ABORT_INT_MASK);
> > > -           SET_BOTH_CH_32(dw, id, ch_en, 0);
> > > +   dir = EDMA_DIR_READ;
> > > +   for (id = 0; id < dw->rd_ch_cnt; id++) {
> > > +           SET_CH_32(dw, dir, id, int_setup,
> > > +                     HDMA_V0_STOP_INT_MASK |
> > HDMA_V0_ABORT_INT_MASK);
> > > +           SET_CH_32(dw, dir, id, int_clear,
> > > +                     HDMA_V0_STOP_INT_MASK |
> > HDMA_V0_ABORT_INT_MASK);
> > > +           SET_CH_32(dw, dir, id, ch_en, 0);
> >
> > why SET_BOTH_CH_32 not work for 64 channel?
> >
>
> SET_BOTH_CH_32 works, but this needs to be done on the channels enabled for the IP.
> HDMA supports maximum of 64 channels. So if some IP enables 8 or fewer read / write channels only then the number of channels come from dw->wr_ch_cnt and dw->rd_ch_cnt. Now the logic is derived by individual read & write enabled channel count. Earlier, it was assumed that user will enable max of 8 channels which would have worked well using SET_BOTH_CH_32() but as the channels grow, the assumption that equal number of read / write channels and that they are set to max count are enabled might not hold true.

Make sense, please wrap your reply, it is hard to read

>
> - Devendra
>
> > >     }
> > >  }
> > >
> > > @@ -79,7 +90,7 @@ static enum dma_status
> > dw_hdma_v0_core_ch_status(struct dw_edma_chan *chan)
> > >     u32 tmp;
> > >
> > >     tmp = FIELD_GET(HDMA_V0_CH_STATUS_MASK,
> > > -                   GET_CH_32(dw, chan->id, chan->dir, ch_stat));
> > > +                   GET_CH_32(dw, chan->dir, chan->id, ch_stat));
> >
> > why need swtich id and dir here ?
> >
> > Frank
>
> This is the correct order of arguments to the GET_CH_32. The second & third arguments shall be direction and channel_id respectively. It is a pre-existing issue reported by AI bot.

AI found existing problem, need seperate patch to fix it.

Frank

