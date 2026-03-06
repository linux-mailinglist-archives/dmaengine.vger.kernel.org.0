Return-Path: <dmaengine+bounces-9308-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KA8KHQWq2nMZwEAu9opvQ
	(envelope-from <dmaengine+bounces-9308-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 19:01:24 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 174F8226878
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 19:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C82A3013EE7
	for <lists+dmaengine@lfdr.de>; Fri,  6 Mar 2026 18:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C24F9E8;
	Fri,  6 Mar 2026 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ku/Kc9OW"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013038.outbound.protection.outlook.com [40.107.159.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F131334E745;
	Fri,  6 Mar 2026 18:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772820070; cv=fail; b=d6Prnky9LkEL2ZWNqdZSH3fr48lJKAEYnSPUEkXiUIoRt8A27V8K4rPftM7KHuBr+jQkpm6jvpVLSRKkF67SRnsyP1m/mHkdalwrmmFxWSpnUC6+LTyAT4AM4htTSP0agzdT3g4vZAFwyVbDwewDK224uJB9INQ+Qazf/zxYVUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772820070; c=relaxed/simple;
	bh=BsNhfSJRTsSmH5u72Ch/LwZqY5/SOcfbDZbJ86TTLq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lf1aIHL4t19P987265pcphdnElsfY5GJRLvBNXxiCNbKlYMH2dF0cmz323yF6YcHj333voE3Et2+Ei0CpgGcmVddjoZzgSPKB8o7eRXF3lckYCgYQNXiOQ+UFPiSKizhMuZydAA10ySHlTvngncenDbCscKPv1wTlO17sulN7Vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ku/Kc9OW; arc=fail smtp.client-ip=40.107.159.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3u/03pcT6cgiNPjyAANFQrdIIx0Nyjoi30QdVIGxmOg1GJV0D4RJVPFUy8rgg3ExogPwfD5K3ulFq/p6v+xih/ik4heRnrPsReSO7FXG/QU7wLCi/TYMMtLdt8s5Zb56+QjKZ+fEXblvP1bz+/bujUGV/Y+MG3Cl15RxHPK8KwUFu3Tu1bSaF79EUyiJjYeJTj4WRBoPfGopmzhF9LAfGLlzHEsq4eqxC8sNJcIPcSpRE9n6YF9mujyt3T5exiV4VgpcID+gKRW9Zw5ebqD0Joa4S8nwPf/MnRxUcm7A6hu5eBhc/M2xmW9Xbe8CZDS2nLWY7jNlUjWrB8hPRhKSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsNhfSJRTsSmH5u72Ch/LwZqY5/SOcfbDZbJ86TTLq4=;
 b=JnKeNWEbkEnMoSit2v/4ktpHUxx66YaURbEO8CaIKnGT4OxldiyCPAMYJ2Yi4j+l6dleejuy88jHqrbay+FI/41hN7NT1N4jfN5kAvfCIbcKWnLYYPjvuPqnTQkZYl6JhH2+DVtYOsRURKME7Aqm3rrOnlbjmR5xMBMkZhh5JEC6HoZuQxJkdc5QKoQT8cWkW2EfdEQYEbDHunNHhu3OvcGxJ5vqoIl4JGZm0WXd+Rn8+KWyed20iMUIcOAEdNsnM2eF4Coo+Ni5eSMhAVlNKTmFejwk6Ey0wzPB8VTlPOISobhd00/ahWTwt5bICpLBRDpX6B/UglEmzaYBewC7Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsNhfSJRTsSmH5u72Ch/LwZqY5/SOcfbDZbJ86TTLq4=;
 b=Ku/Kc9OWMd+ELwTRI9LnvXoDVvwLC6O4mnzV6TWs0iD8qhHumt/FpA618czn0/Qtlg8qDWu1Frwm4i0ecKXjb5HAQtXGwo7zS0L8VqPQXFW+tWFltt5Re7QZ1IqSwRRFWSxMpwwkA0DN8eZTAZz67lcHLjXzwRBF169TO+i2guZNYs5g9LikmR4ZGO5Oub6AUzwVfPe8ykWrlAVEIhJHsJmuF6oaNME8nVifIgj82WBJpGFbkkZ561BLC91aX4TAEw8yoUxvzxDIPbKAz44c8TatMDdVxUfg7vsuwDSPCDTi3sSWl+OsFXxtil3+XTAQsyi9g4WDYi4QzzTaoKk/NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by AS5PR04MB11468.eurprd04.prod.outlook.com (2603:10a6:20b:6ca::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Fri, 6 Mar
 2026 18:01:06 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 18:01:06 +0000
Date: Fri, 6 Mar 2026 13:01:00 -0500
From: Frank Li <Frank.li@nxp.com>
To: "Verma, Devendra" <Devendra.Verma@amd.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"mani@kernel.org" <mani@kernel.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>
Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL mode
Message-ID: <aasWXHLOeDiLOkMf@lizhi-Precision-Tower-5810>
References: <aZdDYJIUuceu0guJ@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120F99F2A675C17B1F649EA9568A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZiFtgcMzs-U2MkN@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120E7C753B717E4C8B9E7819577A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZ4l4IHqObEP8DfP@lizhi-Precision-Tower-5810>
 <SA1PR12MB81203E3A32F0670DB15D63059575A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aahkKZ9EBwWfwy95@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120CE2DB5EB97512E51F76B957DA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aampZJo-9UgzpIV1@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120C4D396C9146409C8C171957AA@SA1PR12MB8120.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR12MB8120C4D396C9146409C8C171957AA@SA1PR12MB8120.namprd12.prod.outlook.com>
X-ClientProxiedBy: SA0PR11CA0149.namprd11.prod.outlook.com
 (2603:10b6:806:131::34) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|AS5PR04MB11468:EE_
X-MS-Office365-Filtering-Correlation-Id: a171df64-e2df-4664-91c2-08de7baa568b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|376014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	8Tv8FQmRVT0yT5E/oN7BbOgShejupwvGhw5T5zFdc9TI3FRdnwQW4OvB9L49LbHRC/PxkjayaV5VqnCH0dpB+CbUmY7egmbVXtBoWojlq5/IQrIlHrdmXrdpgUdpvmWM2EeIRM6jFxLoTah5uxhFbFmqGpWeOhQ5sAYU6+5GkpUXka6NSam8J8+vLiv5TdNVCB3rlBjnyDTgqYWocNfKOcKKF26LFmsYxaJI6ceoB2IXZZ0eMv6sBLorfhX9tchdoN5CIQwLXWpvnAEPryn3ErqWA6qOSKFwQustDoEvsTNvDi73sJ+iYe9fTj4uxEbTMD/h1HMeAa4NNitnM+c/oI7jyWX4k5SwvKwQzBVJXE5YSakBBzxnbHmtHx/qTQY2Rg2PZhni6xAdgJOI26YX0yQJj/3a30l71g5Zh5klFVre6RI8mt4hLCwGjxPVEszIslZSMl5KmBfomUcqWo9ap1zHy48ZTwZFJX7g+o1Fm/1s2qVRoBRlsWvZXodpNwVTmbNGIUimYLWTPzrDWY9mQaJIqcomjLhI0TlznewIG2zPIRqUXXhHymdWo6aXDROuEIPkDGT++V/MSA9hfXefj9L1lK7KqOzn+fZ7BRKRkEyla5P4Z8os/h1LjffXofesbSDcqMJUmYQQAm2itVcg+PxRyaq8+jiZKj2nje3ZFpI11xyqK3z6EZeBfez+7P+2sEOsuRQ1biAI8SPQsXAOwdjQcPMrlQuO/yOxxF/2GA1x9Agyo+7so4oRQI88IVqCigyFvOW45Hi+kdZuQnJf1q8ZZFzV6v/pcsxq1lj6awg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eSll2luU42SYDuqqNkGWJaT6WP7rrV7gZY9JROLJuy3Aki3nSmeMz7vH4fB2?=
 =?us-ascii?Q?sbWSqNgf561LG6nlu2Tz6g/zwPo5ch7S3mf6pryd9flrTdmaHizHccA5qZ6w?=
 =?us-ascii?Q?DiMZP5IMtFpcZuvQSPS6E9o8X6SEsQLGroZ4B4P/WHklhdHtnRgjcwbJSbU+?=
 =?us-ascii?Q?yAg2dv5XAUXudlhmREhEm30GzN78eu7hZDJAXmubzX3spPl1AHywNav3KjzJ?=
 =?us-ascii?Q?NHRd3OiS0IwualgBKqkXQD0ruw+nRKYI91IcQgq9rUKDGWs+GfClfiyJFUqs?=
 =?us-ascii?Q?qeYQcKJrDZTNCRfWlv9uVejUHm25xbbk1vixXdSGDGb0Ca6Xn3jp8bB6MnF8?=
 =?us-ascii?Q?LhttKO/MdpLCuiVmGRA6h7nf2F23VmpE3/DuKKLmmTMZXwl2VuvFvm8maTar?=
 =?us-ascii?Q?HKmpa9q/i67dHzYMMuPuzGKrDZ8TQOS6EzeEY6XK6gqnHvLWOx/jahiolBHU?=
 =?us-ascii?Q?xp6L9WHTZNNlGLfnreGvJDIp/I1Yoeha4Yazc5ABrLqEY7lqqQDVeW8qEhhC?=
 =?us-ascii?Q?7PZWmC3LAXadpMcKYcYUX5ngGLno10+2VxsP75jko/pYuhcLZsqi2SiK8A71?=
 =?us-ascii?Q?U/KycpX3aDfLTqqgb+OPbMKecWC+Z9zS4YQp1MgUHvJhiejgBVdJ5UoF5cbG?=
 =?us-ascii?Q?TelSoAYwsKJdc/v4Se4K0Z/5ytdpNHbNDqRukrRn7I5jFOPtpqkf96IhreKC?=
 =?us-ascii?Q?6UfxiiaR0W31iEl/JIsmYzN7ol7roESjbiyv3z/PjdehUWZXINsyKClFh6gf?=
 =?us-ascii?Q?7YvIqZfSEHQBi2788CdHprN9b/JZjFWeQRP4J9+rvagpYjJd+riFNdF89P/y?=
 =?us-ascii?Q?yQnilE819OGsp+DfGIbWJYbz1OJbvSzGFur5652ikRKqdZ+G/G8vyqNtXKGE?=
 =?us-ascii?Q?5sdn41E2vJdPjWGJkvCpw954mi9Q1zS5naaF7hps8PEHk/W1BQXs+LG/PO/E?=
 =?us-ascii?Q?UIf4UGWpyiKJpuKXdmBJBi13rnIPEbwGiAaaOcT9+QDOBKI/AfcvWPNNYbbE?=
 =?us-ascii?Q?sXghKOW91ZUEjbVXgilkYTSctuJF47O5s3rl6GxPxZz8RpqiuV24r950EQ8U?=
 =?us-ascii?Q?kGXlhMqHpej6Neny+syMMTL29XkQt7yvUDc4cnevoiYykvXQ2VNaL9bngDtO?=
 =?us-ascii?Q?JD0l0qcqOXOmuM035a/efDypwZhDJ58K/xIHvmV4sxjv2bLdQj1J95HJCaxj?=
 =?us-ascii?Q?oZw+dEcjM3ceG8VJ1n16FLNDIVmZ10zKEqYWlAFf4dlYwsUNGuC6XtbAmMp8?=
 =?us-ascii?Q?GVaXEZ2GjycGuyk84VrC02ut7lScRIb1KRsjdiDr8pnB+Wu4KQM5EdP0ZaA0?=
 =?us-ascii?Q?+ufJIGdY8UDqqfumbsiqqHqolf9XYGxEVbkqB7QkZFsRqtMhoN/QNRubU7OU?=
 =?us-ascii?Q?4LXCZa8tGQK/GDOus4OBatp/iCTmcnZRigVHk3bHX0b3PUimYfP3P4OqB9Q5?=
 =?us-ascii?Q?mpP9DapMbZ+Zaw0TOXzGFVcSRXI71sDMtilg7315hDRKTnBW1Wy3b9r/de2t?=
 =?us-ascii?Q?bH6u/A606d51KqRK9L9+WPe0Q/PXxKTbiO2l1se5ZnrrbWzd2OBY/hVAYjW7?=
 =?us-ascii?Q?aJDj5K7rTwE5OPmmZdVRCSSwXMvrZ3xiglFDwrvpcIS8HZzd3FOwjaqE2YKm?=
 =?us-ascii?Q?nzSkBv844OEGZyjeJzFbHu2P8zRK3K7zROs7+Ou/3iIGwsI/Z9mnZqodNHz6?=
 =?us-ascii?Q?A8Mfy49YXpeh0NNN4FBqbmH97pJritlhjD/rIqidMEyp/RjT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a171df64-e2df-4664-91c2-08de7baa568b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 18:01:06.3749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IP0TZikPxJGRdeTTpm/DVhxgxpbSIaIzykorhmeR5eBImbw+xml6XJieY7j9JKdGtGa9Mb87AJOateax66Y1Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11468
X-Rspamd-Queue-Id: 174F8226878
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9308-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.954];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:email,nxp.com:dkim,nxp.com:email]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 11:50:39AM +0000, Verma, Devendra wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > -----Original Message-----
> > From: Frank Li <Frank.li@nxp.com>
> > Sent: Thursday, March 5, 2026 9:34 PM
> > To: Verma, Devendra <Devendra.Verma@amd.com>
> > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL
> > mode
> >
> > Caution: This message originated from an External Source. Use proper caution
> > when opening attachments, clicking links, or responding.
> >
> >
> > I don't want to take more time at this kind small stuff. I am fine if vnod Or mani
> > (who pick up these patches) think it is okay.
> >
>
> Frank, could you please approve the patches if changes look ok to you?

I will provide review by tags if I am satisfied.

Frank

