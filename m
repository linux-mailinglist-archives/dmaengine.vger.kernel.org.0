Return-Path: <dmaengine+bounces-9252-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMS9NWNnqGl3uQAAu9opvQ
	(envelope-from <dmaengine+bounces-9252-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 18:09:55 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B390204E8B
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 18:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B383305F51B
	for <lists+dmaengine@lfdr.de>; Wed,  4 Mar 2026 16:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733AB376BD6;
	Wed,  4 Mar 2026 16:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e8llHCri"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011000.outbound.protection.outlook.com [52.101.65.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9596B37756C;
	Wed,  4 Mar 2026 16:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643387; cv=fail; b=aNFZjLAlSJ4eKt81d0ZOdCOynaOc0DDlG3/9mfaBb3JD5EeKBnwHVI/EMzZgOyRSGfmCjqnAHCC/wNLkXVK5N7mMl5iHNMEGlKiajzFCvc69LeCpv16nqQbnajiCEm2cZewxPAewKFH8sRzjPfDsze4nn11Y+q1HTnNUzwQy24I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643387; c=relaxed/simple;
	bh=xtGQisZytPv3qimHwzcjkIsRoadG+AxSlfb07k2D0PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CjaUj1f0kWt5b1SjVCNpnNmTH3IWx+JISiC6eCxxWBqVMasiCKtzhsmPMy1TSRcruvERH+klIT9QgqI+PCtHQ27qNSmhnJrwdX9vF5VdBRm1eKga7lCPjS7JJETZEYHOx5fN5aaSb1XamCnj1ze2uIQERuhSzKD7Yiv46oDDxFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e8llHCri; arc=fail smtp.client-ip=52.101.65.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JAMP5YDMZqVey4CBb9YxHM5iWugANbe4Iuop5631f2WbqlDNiujQpRGSR0AxIL9upMHByR/ElgVjbtPLkFtU3765aHeOJwkXUUNdTZFe0HkAmL8rlV42Zg/N31vtqO/GfwTMZ/5BYxiOsusUtiebvXEX5lMa3QTaqtAYJBYXJn/3vIdgCM056jp/v9MQU4Jk+fr2I4NF5Kpka5c3kdwIulfjnflAmSOdKVRpmadArKddpb9m83AEg/AYq2tiFSgjEkqYwbThJtKjrv141m6lmhf2lU0n0RkMMTLr0v7Kuf6HL02eCEf0L9ik5BYNwW86g0aJc2wqQyh0lPkWWaaOWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkWYtIODR+4c9LcNZHe19JO+eW4kx0uogBMke/uq99s=;
 b=F/vcHuWqDiJjS1h80LJ9NDeb/7McvZsiwvGF6owXqJfyicDwTqEpzsjJk4kguzZnAyArXRTCPjX2KDLFEVXIKPYrOEn6jppiYwJigmYCbsl/TNdkfSxCXRRFgecWARdPej6R0tNqs0C+MVFzm23FWTC77CaypY8efFka/oC2IIKifj15rQkQc8+TrEJeSW6iFLpJHPpd2c8XZxALOKvvaNTdtqA0NED0z85cfeA8bPacQ5p1fTQrISHDv4tdBc+HIvU06svuxDBkKBeZl0XZeIBpVwhYVGV89nzxWNHUWjVP12QrzRdf0nhDvpkdv7l6LqDszQi7PFP3VLcPEysDcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkWYtIODR+4c9LcNZHe19JO+eW4kx0uogBMke/uq99s=;
 b=e8llHCriM9ERvtMz3J/Bil2FP3IvK//kv/dvQVcfmahpkOrylJgPNOt3uCNC8oAxXAgX4VuMs887hxI7MfzB1j3Me7d+xd/fMVPPfrIO56aXfF2Lp53NJxkenBNcQg27X88W9nMfW8g7I4u7s+j6vOC+FAznDdPDSxJi+dp5qTioOmc4HHxi+44/+caN5yCmuJUWa52ugyO4h6TKBIM+EO3R590H2PARtiyP0UZQBaQ8p4ffEhKkUYr83MrcxC8WQXNfe8QyPqHyhmo3+9+RjK+0Pwr5MP/4lxtVTAZ33e6I771Xagq3McZdCQpPKXAK8k7eDzFkmlyKE43swySRgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU4PR04MB10982.eurprd04.prod.outlook.com (2603:10a6:10:589::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 16:56:16 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Wed, 4 Mar 2026
 16:56:16 +0000
Date: Wed, 4 Mar 2026 11:56:09 -0500
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
Message-ID: <aahkKZ9EBwWfwy95@lizhi-Precision-Tower-5810>
References: <aZSZrROMrvt8jHvw@lizhi-Precision-Tower-5810>
 <SA1PR12MB812019D701E0B188611DFE7D956AA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZXfmKs5_KzCDSPq@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120DC54060E415153AA8CDE956BA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZdDYJIUuceu0guJ@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120F99F2A675C17B1F649EA9568A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZiFtgcMzs-U2MkN@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120E7C753B717E4C8B9E7819577A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZ4l4IHqObEP8DfP@lizhi-Precision-Tower-5810>
 <SA1PR12MB81203E3A32F0670DB15D63059575A@SA1PR12MB8120.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR12MB81203E3A32F0670DB15D63059575A@SA1PR12MB8120.namprd12.prod.outlook.com>
X-ClientProxiedBy: PH8P221CA0038.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:346::9) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU4PR04MB10982:EE_
X-MS-Office365-Filtering-Correlation-Id: 73b4ef50-c0d6-408f-9a14-08de7a0ef333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|1800799024|52116014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	q2oRketY51qEXgslrSk+PL5pqqyftlZm6kvSEn8sW0qPfMSLmRIIHOeMyI/BnBPO047FXom/ToNE2f56CHqKYitVqYY0vwlvBzQw9/0CDZW/UySlPi/8smHBp5IIZH5rwqkdTy1xda9D7uW4ldopBKJpYbHb06n2TAzvSmAgHTr7CHwax6ZL02K1MUXlrSVd4qGBvVrpkJZjWiPmw9l+gwZlDxC3VjOoRplGMG9FSARV+SuXtbG373SAx9QS9pdqGV+L/AG4GlMJY9G/6SrVsALLflcdE6Z5+thr+viGwjzK6eItRTJo5Vez0w356ldyxhMsCdHNVkXnFgeA/UMlv4qyi4QQhxbc5XVSBTmTw22pek/Q570HByaJr9FUWh+CuM3fyFgE6ZpgFfmQBm5LiW460A6wfSQ8o9+s1RB8+3ux1TNRaQK4b5dmplpQEgL8kxnixo56Dvqb1Fd5BIgF0FIECRQoK3iVaP1oCPtBNXX6d5rVVgf2+fVCSl5nKNp7bUiFQ3t/D7H+XHaPsZJs7hL/RrScDk1OCGW0RK6+xNaKVbf4Sy6zWQzPAh4XgNjLrnQLECKD8I0auQUlNLy7yXQxLPKHnF3qnAaxbC+pWL5AwtN1kMJzKeOBmvU8OdOr8sMIgcfxsga/kJw3tzBle1PE60XpSXH1xTkKZ4v9czljXR3EkPJh20ueJAme7C42AFDqRJM4CeX4jf6/r/04MyVse0iM7tO/O43cf5kePdRkdbtN9PLELEDkr+tPcsE7Vj5FVx8fDJobW7JdJYn2oJC0xwGUzAv3+nJdrYS9G3o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(52116014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7sZgASF0lXBPbGBQhPlREr2dpkXT1cYBdTM80jeN2QLSDMYJYpcBihZ3PfUA?=
 =?us-ascii?Q?jGiG7pnc+wdFCOfRzQYyYLqLRTARJVUQ+daPXLD7AR0pVtnflzINoiJUj8t1?=
 =?us-ascii?Q?jLgp/iNSfEDD3kslsRL7+F9CsnrHAcNbbSlrNzq8wygG1HrRG4VKqwrvfz5S?=
 =?us-ascii?Q?NZdF166cYtVaN8SQea+6xu7iAUNjGmcNn0UXZAXBLnIgC+ijAtMRGrge6uHd?=
 =?us-ascii?Q?j+rflbcLG3jeZ5HnNY/1M80wIp3IQdhhQGQDsJ/1nXCtoL9PqjFbmRC6xlxF?=
 =?us-ascii?Q?DUCnAn4kZTAiEQL7ofHoJX7Qfkzkyk4wYSfqVoKoBPc9qK4Jt1uTut5c66w0?=
 =?us-ascii?Q?j34x/djy+QI76JEPu5kWZOl+pJX1YJ0b58PUDN1fq3H2Y5Vre4d+KOkzHGMz?=
 =?us-ascii?Q?8oKNVWm6sfETUBziWyngOgFzfvTHCQvz/wiwlsqhS4wMKZLAI23BHa3rYqqJ?=
 =?us-ascii?Q?FA0nwWPbANsFeXVYYeKu3M+cXm7HLzMK+LRhx9W8X58sCMPh/hftjI12+tJ+?=
 =?us-ascii?Q?bGA/keJc5lSE3e353oshcVrpWF0RfbOAvRNewzpQBC6F/PnMmzZQOjzgPygV?=
 =?us-ascii?Q?moUct+DE2xw/e8bs3tXR/GFxrMvWCZVTtF1T0gBOWdHIKqORJQDDTh1Jxv5v?=
 =?us-ascii?Q?OdE1SlqCOTfK94romzccMpwxWC/t/OsafVzU44Uqc30xCMFO/r47Gn9lt39C?=
 =?us-ascii?Q?cUNh2Dam2HmBWp2sulGuvvQ6GKBTDzTl8AUTyeBI+ZbhhzsavBskluR+tQzC?=
 =?us-ascii?Q?H2GgOhLUKftdBrCTvEA7xMREn+Z7bS8XJO6TIW0QPo3g5yd4bF1y3DNDIi3f?=
 =?us-ascii?Q?J+8mY1LT8trJYY4IhGiFtIaSv9lqtXmcq7rLjK7rQyCw/wbrirPn8WwsHiFp?=
 =?us-ascii?Q?gGiU5COcBPe0Khj9761OMg8+U90NOOV0uaLQXNxvMyruj6Tg7mSgz5dJ3zU5?=
 =?us-ascii?Q?+D/oeIIV5FWkzvRIjxZe4RAsttt892N9T3ECNiJiKSwDWcKbPIkxm+k2lps+?=
 =?us-ascii?Q?paqlTnMYpLhTYmI2GLIRh2pSaMJFOP9Aj9C+ECG1nG3pD3QKzmXDsKyhDHfa?=
 =?us-ascii?Q?6y3ccf+gtA/DmSFaSOoPiUYzPv7ZFfHm8JfmDFqTXKgBNAdGyU0305NhbZcl?=
 =?us-ascii?Q?NWKLB9YNGoOeIQrQgMmfIjqw8HFNwjRdNhZxUzdH+a48KdKQdyGzVtZ+0Dle?=
 =?us-ascii?Q?txu9Z2tT+uJ+TN9dLkZ1LN69AT2q87BK1C+L/rC4TTdB7kTyFpOkCUPOrkzK?=
 =?us-ascii?Q?6GfpAo4udH7+cE/br5Yq6Z+OltBTOF3bcVJcd7tEQPlFsTMDQrVKklnH6SRn?=
 =?us-ascii?Q?r0VR0JITNb34CR4n18hHM/62OkxKPxWhmer+3nrfVDDj8mPslUOb6Xn9vzT0?=
 =?us-ascii?Q?VrWARATUox0ssa5n+L+V7n6e1fx6wTnkCyiow34f6ylX+/OtMMgmF+qE5zoF?=
 =?us-ascii?Q?tI7YZtiy7pcqsXCwbzQqdwaUspsxvMp0SOXMytvtPUMOCEcO5j7rfvsQgouV?=
 =?us-ascii?Q?YvQQTu3ZCtAFUoz0l6uGmlmoeTgTT3xgpAy9X3F22fS3PhMYcidp2Q6Ted1L?=
 =?us-ascii?Q?ikL+vVrAnrzEAIkYd4XIiMod7pMT6lsWSx0p2o0C84rLpJBWbOoE+g2Y3WPA?=
 =?us-ascii?Q?mKvpkHi9mIAasrJ9OGSygtJD7Nacq3iXaDM2cGwYDIxLqBqRpDTgtDTzDK9c?=
 =?us-ascii?Q?wPJlhjaFRBOnQfc1cMC1euKs8jzRFaJr6APnIp4KUkRNGysQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b4ef50-c0d6-408f-9a14-08de7a0ef333
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 16:56:16.3277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mtewJPNbSQsDupt2y4HB/r48uY1Kn6yizNldOHyurdVPnACgr0aAHPXXvkCA3XOosq2/orezgakcI0CSXluoWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10982
X-Rspamd-Queue-Id: 4B390204E8B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9252-lists,dmaengine=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:email,nxp.com:dkim,nxp.com:email]
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 12:06:12PM +0000, Verma, Devendra wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > -----Original Message-----
> > From: Frank Li <Frank.li@nxp.com>
> > Sent: Wednesday, February 25, 2026 3:58 AM
> > To: Verma, Devendra <Devendra.Verma@amd.com>
> > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL
> > mode
> >
> > Caution: This message originated from an External Source. Use proper
> > caution when opening attachments, clicking links, or responding.
> >
> >
> > On Mon, Feb 23, 2026 at 04:40:07PM +0000, Verma, Devendra wrote:
> > > [AMD Official Use Only - AMD Internal Distribution Only]
> > >
> > > > -----Original Message-----
> > > > From: Frank Li <Frank.li@nxp.com>
> > > > Sent: Friday, February 20, 2026 9:33 PM
> > > > To: Verma, Devendra <Devendra.Verma@amd.com>
> > > > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > > > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > > > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > > > Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL
> > > > mode
> > > >
> > ...
> > > > > But if it about writing a new function to check the LL mode
> > > > > support then I think the current variable is good enough which
> > > > > provides good readability and do not create any ambiguity compared
> > > > > to the ll region size
> > > > comparison.
> > > >
> > > > It is not big deal,  use 'bool cap_non_ll: 1' in dw_edma_chip. So we
> > > > add more cap flags in future.
> > > >
> > > > Frank
> > > >
> > >
> > > Hi Frank, could you elaborate what you mean by adding the cap flag?
> > > How it is going To help identify the overall chip state?
> > > I do not understand what is being implied here.
> >
> > non_ll in chan means current status, which indicate one channel work at
> > non_ll mode or ll mode.
> >
> > here dw_edma_chip means hardware's captiblity, indicate if hardware
> > support ll mode.
> >
> > Distingiush hardware limition or current working mode.
> >
> > Frank
>
> Thanks for the explanation!
> Hardware supports the LL mode / non-LL mode, just that there is no
> piece of code available which can perform the non-LL mode as only one
> mode was supported initially by the respective developers.
> So, providing it as capability does not look justified as in any scenario
> hardware is capable of non-LL mode. Theoretically, non-LL mode should
> have been the default mode.
>
> The non-LL mode is not a hardware limitation either. LL mode needs extra
> configurations and in the absence of that, interpretation could be, enable
> the supported other mode which is non-LL mode.

Yes, that's reason why I don't want to add non-ll in dw_edma_chip, which
should provide hardware's information.  non-ll actually miss ll_region
information.

>
> With the current non_ll inside the dw_edma_chip, when non_ll = false, indicates
> It supports both the modes LL and non-LL, but requires user inputs to enable it.
> With non_ll = true, the dw_edma_chip or the hardware has no choice but to work in non-LL
> mode only. This is the interpretation for the flag in non_ll.

we need distingiush current state and HW/SW captiblity. in dma_chan, non_ll
means current working state.

but the same words 'non_ll' in dw_edma_chip is HW/SW capablity.

dma_chan: non_ll       means current channel use LL OR non LL.
dma_edma_chips: non_ll means only support non LL mode OR both.

The same words "non_ll" means difference. We should try to avoid this case.

if you want to add field in dw_edma_chip, avoid use the same words because
their means is difference.

Frank
>
> With the capability, would it not make the statement, that if non_ll = true, it supports
> non-LL mode but that does not mean to be mutually exclusive and not support LL mode
> at the same time?
> If there is a requirement regarding the capability then it can be taken as a separate update
> but I am not sure what purpose it can serve wrt non-LL functionality.
> Please let me know your thoughts on this and lets conclude.

>
> Thanks!
>
> > >
> > > - Regards,
> > > Devendra
> > >
> > > > >
> > > > > > Frank
> > > > > > >
> > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Frank
> > > > > > > > > > > > >  };
> > > > > > > > > > > > >
> > > > > > > > > > > > >  /* Export to the platform drivers */
> > > > > > > > > > > > > --
> > > > > > > > > > > > > 2.43.0
> > > > > > > > > > > > >

