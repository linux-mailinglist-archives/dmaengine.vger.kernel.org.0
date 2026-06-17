Return-Path: <dmaengine+bounces-11579-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N30jNdSmMmrR3AUAu9opvQ
	(envelope-from <dmaengine+bounces-11579-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 15:53:24 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B54B69A47E
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 15:53:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=Yb3wX7UQ;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11579-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11579-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96FBD3032F47
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 13:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4925B3D47C8;
	Wed, 17 Jun 2026 13:51:59 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012041.outbound.protection.outlook.com [52.101.66.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6D330F547;
	Wed, 17 Jun 2026 13:51:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781704319; cv=fail; b=Kgw6OiZPdx0s3Jvhe0iLuBGD0UAjiNU4odzCQ4RBZT6NxtD63qfssTQNFQ5OcjcDUh5Ph/PjWXKEB9UJv3oRzWbzUztIvWSzJNudb8Ia4eWguv4ks7n9JkVuQgDy5UbS9SncntgGfz7FGUHJGOoqvF3iQkun30ZdpjD08epF/po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781704319; c=relaxed/simple;
	bh=R4ru3+EIpHSIVsgAhGdrzXl9y8RsDE1Hd9Oetbz4qeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fTKn46uzzeXvYnURUsFRlI3Hz1yD9L2hqm802WvuMBnZs7JU1vZzZb+W8taCACM4AX1o3upI+NEIqPl4kxNcLNh3I5Up455icrQuStKsmhevPcr3QsSuZp2U+wnKr3uym7ykrC9G48YH9ig8DrqFG9S19ux7nHM6Dd7eqGYu9bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Yb3wX7UQ; arc=fail smtp.client-ip=52.101.66.41
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JPQl+n474b3+I+HJ+m5iYJsZ9j3LiJ+TMRHM5cbz8eA/MlRFWhbdcL2fzfMAXjrzxrd9N2Y5xTUh1Kguey2IUN6wSQc2NNoac6fo6B611pFNnqTpto5mk2MY65ah0rfhmlrtGKa751QN2bJLQuMyBM3RA/ausagQCyDPIY+g49oamwi6Ii2K2SP9DiICGU3r1p7Dz2Zxz5aQZ64OlL5ZuxSK8yTOpCnrKtzQ2PQerr+XOd6POCmeFMhk3d97S86t93Aw9Dxf8ybdbrp/mUaR0eLNcbJxEn7TIypXIQIfWKJh7dQtxgiImUC++4a3oAvYEboZtFrw74YP15lP6CeWtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfIs1apXXO28U47LjgOeXqDQX30fbpKj/ZBVVErL70E=;
 b=rudRBjJ4oaNsw8moeLewIZ3qyxVhatj8nexl9uct00NJbjIOoLRIhyUmcWNdxa3Etud9UvcSMS4uHgKyULPko3/FFrWQflNCgJUS14IlTLAOI3pyqf/+QjNqYnkWP8BNJLhPjUixvQfeI9GV55aJQpJ+bpnynhbKH36+zfpFxKLOyzOBJ0zOB4UaPtK93rYO8ovlbC1/GdAUT1yR/SS4NstmBI3x3FYE1eyaWD2xuVuptXKFiopbJ3SyeznnE6fYSxMlNjPCAIDvq+4tJnz/0qJwpUFMDBdS17JBzB/pWRA19ahL0D9/Fp29Y7TfVdTPsjBQH2tUqPx8YAeQTEd+7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfIs1apXXO28U47LjgOeXqDQX30fbpKj/ZBVVErL70E=;
 b=Yb3wX7UQvxkMekn3PpFc5CN6Q97Yrny8IpsauFKHodhhIWYfiNmgEG/qxS7Nvg7Dw1DO8Xzrb97PUD4itazIiAohY/w22tOO3AGUCjpEipcqSTCMAYoKSHC597/5YLx0HOMPY2JQs130JIon/fma4cuSfNZgmTuPsJNXt698WkLzzccMenPdI2N6XsEwcXnt8K/uim21Hc+/ldTaiqKaQtNq7YSjFgWPezMM6UXZI5xAYC+BdWq18JVZvo6YUgrxXEbqV5npQ/zNAI7PMjiJ4CxWd0dYQBJyJ2D9uioHdlTmwcKv5lZv6DFlAQJhO0sozKXSoxyHg5mrI0VunyOD5w==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PR3PR04MB7209.eurprd04.prod.outlook.com (2603:10a6:102:92::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 13:51:52 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 13:51:52 +0000
Date: Wed, 17 Jun 2026 08:51:43 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: "Verma, Devendra" <devverma@amd.com>
Cc: Koichiro Den <den@valinux.co.jp>,
	Devendra K Verma <devendra.verma@amd.com>, Frank.Li@kernel.org,
	bhelgaas@google.com, mani@kernel.org, vkoul@kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH v15 2/2] dmaengine: dw-edma: Add non-LL mode
Message-ID: <ajKmbwr4vuN8cFuU@SMW015318>
References: <20260318070403.1634706-1-devendra.verma@amd.com>
 <20260318070403.1634706-3-devendra.verma@amd.com>
 <zhpsuwq5agslelgebbtvrg4uks4xweov7ywhmkxdngq7lzajip@e4umiii6kzko>
 <4ffb23c5-de2e-44f6-8d15-0f9ac563b609@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ffb23c5-de2e-44f6-8d15-0f9ac563b609@amd.com>
X-ClientProxiedBy: SN7PR04CA0050.namprd04.prod.outlook.com
 (2603:10b6:806:120::25) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PR3PR04MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b552858-77be-4ce2-8cbc-08decc7795bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|7416014|376014|23010399003|366016|56012099006|11063799006|22082099003|18002099003|3023799007|4143699003;
X-Microsoft-Antispam-Message-Info:
	T51onPkECqTJ9jU+6qBgmbreqzPakf6juB406zo3tK2b/n+USVUPLruHzkkS7f6Eoj6inGyxvHSECtWsiM44olU7HH3XgbdtXsql4v2iwPoXQJPhg18jD5M5tH65arjObKciaVIZ3TR4bW/MBWs22+JG2hfXXtmEwZd3lpr5uYFttNrY9SpqxtRQKXd06RsmgSQb5VdoJ8vd7HQ5S25iexgxklhu7ZqIlfHOnQFnmCHWINnwkaSjmgHhrLbFZ+hZ+rikYY4vMk6dd/JRP2YKeXi8UiXNil0ExP9kUQ5k1IgrT+OkWAV509f4SDCI4jLtM6iiJikdKp3aITFN033Ptae9KLQtx8TTWDqUpFmKZ71cqs0/663hIsk8Rkl/B0RU62QVAbeoiZHKiom7yvw7XMGaeIgSsQ81FEUWxUym77gULTf0iXfobrEzKtQ0VffUas0P7miiiRIdiAoPOJzwb1fmsBLNCgHvlLQc5v9QNirEverFNtW31LBtz5cUf6JVeznK0EYEikylLWPdu7n+ewGzTBOn0yzkDKF8oACgDGaaHmvJvYqmFu2qtb8zwJfJUFGi8MrkdNlBba5tJmUNWr9N4b8iC+FHmSDb18vATjKBHjOGq+yXPWDuPrjf6qtp/uoF92XbeltgrDiyoa2LDIr4nZ6NJLc1cWmaawAvCb3WePPk6rjahsvVwn+MleW+AeiBcbeuwZFk8MXsCfayJA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(23010399003)(366016)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pR8m+et1Lu8elYPgIoEPFLDoDnuiaYHWslO3169A4eQT6iawhRFiNqe9HZ7A?=
 =?us-ascii?Q?GAf79zRLT7Nr3pSvWCFIXs00qoEIUsBVv6NtQzQXtUMD2jMKqjTNSkcW1KqJ?=
 =?us-ascii?Q?PoH/tH9sDyHjFXF9rZ8NC0Xn6QTpLGcTs9Lq80XM06BNB5PGA+PuVsQo7Y+A?=
 =?us-ascii?Q?MIvsQ4OPNoDPEx+jLmEhQu0k4k1DhJx6haM4qWbJjoDezagT1ljMZP73V/Qg?=
 =?us-ascii?Q?AKDDx3qJWVOWOMyQM5n4/OGC+ElaXeME9Hzkxs91wI/4HvwTIcOzxMYKDeZt?=
 =?us-ascii?Q?COEXZgrw84KEwIErqZCSajm2/8GFeTpJzBpo5UzJJEoRhcCA8d7MF+wDa4fc?=
 =?us-ascii?Q?HJRz6go4WLf561hdewJQTDd4FmlayCO6pwj7bBwnbawKzIdQ5q/fcTSno8vg?=
 =?us-ascii?Q?JGL3+qneGLphg4nOH0JE0mNFjSntswV1sILNR3Fb6IZJrl6V+GJezSzWtHbg?=
 =?us-ascii?Q?6pxpvg+2w/Ps1mgajawJKbbJ2yXHvDLLzBiokcBHbU7WAgaY2srxqJMSajsL?=
 =?us-ascii?Q?c6Ij05+1vdRLmzPNshCGaY0pJlVKaXtnDLGwWnEiieb6dA2sBq0YMZWKnqIt?=
 =?us-ascii?Q?sW3ahv7jE1b69f5ii59tJHMpOIh0PBXU5B27ZGZQQagg49MJ55dWiO/Q2h3i?=
 =?us-ascii?Q?BrKz7KjX/VCSk87kCBb/U87Gchx05rgMmaVA+QJx62AadpHGljc+rWyrZKUc?=
 =?us-ascii?Q?1kD9wJAl+GpF5QpqBtW8bRrjh4Mw6TdojdTrdPr9AeMy4pfOBKxM3CGlxRTc?=
 =?us-ascii?Q?t2m2WREjar6VAC1tMNkxyqhthjNWajS89P5d6gRHI6bl4mY9EIAjN9TPnJRU?=
 =?us-ascii?Q?+aMUuJlzZcwY3JKPeAmlbcya36wT8twShgXENuriW9Nx5CerIX1bYVMQiXms?=
 =?us-ascii?Q?3NZls/gjntJMrDdWWPscu3HtScgfDgQ49MFCuEtzZRrVAc2jSfHAWgUEzDLu?=
 =?us-ascii?Q?M49VzXFTIsWKKk5TyT86byon/NMzxnW/asAVv4o4Al2LBoq+cgO1nnpR3/Bv?=
 =?us-ascii?Q?gK1CBATeZcTKV9doZ2aYIFO8iQWn5zi6BoqJCyPPXeDI8UWTF9ZdofPlPKb7?=
 =?us-ascii?Q?8yvPPU0Qb4ucGVwLHJKFdgpl3cbc4jJNLuVg76ShFfXSzBMmT71tEXjrEJxK?=
 =?us-ascii?Q?SeXqHwCkXzdNQ7OK/L4aD3x+R8sJWBgZRTKlfeY1qCMBSevIg2YZj19h7KIj?=
 =?us-ascii?Q?Jx2cz4nJWSyRYBPAOW4Bzi2ocxhjrieC8nsdjWvQO5iGrHooq/YWz2PtoVEi?=
 =?us-ascii?Q?+aFCu5hRS7h17cDB3Xjm3V0hwajuqGDb3ksSNrg/BZde5k5938rGs1EzuLNg?=
 =?us-ascii?Q?Fx0DOlQuBBUA29jb1sjEvSE13Cp+5UYmH4yWbmgiajMpiGJqM4+QnLPXQT56?=
 =?us-ascii?Q?TtLIlHXDqMYu14tIiBFvnY7nlD6RmRDcvcbRBLRJ6nXROiyXEdWGNFQdn6Sb?=
 =?us-ascii?Q?YXxb2I1eeXoLTv9S3YZeXm6ZYKoZAVrpvvTqP8oKCiKfxKGE5VtckVFcPDdx?=
 =?us-ascii?Q?BMhiPPILRLkwG9/VDXfrlsutEgVD/d5hoJwcW71x9gpHg2shbM/XlxVPI6eZ?=
 =?us-ascii?Q?s2szZyagRYRpyHN/LuVGx7lN8BMGjpcdxnru/Lgc77OuBuxOhW0GYQqq/poV?=
 =?us-ascii?Q?0mNdi7/Yx5IZhw6hWFf60Ao+YxsF/e3UbItmQdcPok5m6B+iPudJu5pw0TGK?=
 =?us-ascii?Q?e5pqUtmrUCt8ftH+ZRHqPn/zji94Lb/5M0+ZHVIwTYulY/wblCZhCG9ATLMb?=
 =?us-ascii?Q?5E8436avFCEEXehq+G8+VcPT3rfM0K5ejW7vG8FA2jJYf90gLJJl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b552858-77be-4ce2-8cbc-08decc7795bd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 13:51:52.2196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19AADiOaLB3tB/X+2bq/nBBS8z2RzGQp1sE2h5iE35guwkV9BxMQs5L28FjHWPo1BTgZQCmsgjgD1e5M1Gh/k1LACmRuHWAjtmMIWu4SBcisMsqbAzPkZdPtmMA97tz9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7209
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11579-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:devverma@amd.com,m:den@valinux.co.jp,m:devendra.verma@amd.com,m:Frank.Li@kernel.org,m:bhelgaas@google.com,m:mani@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michal.simek@amd.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	REDIRECTOR_URL(0.00)[aka.ms];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aka.ms:url,oss.nxp.com:from_mime,vger.kernel.org:from_smtp,nxp.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,NXP1.onmicrosoft.com:dkim,amd.com:email,SMW015318:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B54B69A47E

On Wed, Jun 17, 2026 at 05:13:32PM +0530, Verma, Devendra wrote:
> [You don't often get email from devverma@amd.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Hi Koichiro
>
> My first reply was auto-formatted as per the column limit but got
> expanded after I sent it.
> Re-sending the reply with correct formatting.
>
> Please excuse for the spamming!
> regards,
> Devendra
>
> On 17-Jun-26 08:47, Koichiro Den wrote:
> > On Wed, Mar 18, 2026 at 12:34:03PM +0530, Devendra K Verma wrote:
> > > AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
> > > The current code does not have the mechanisms to enable the
> > > DMA transactions using the non-LL mode. The following two cases
> > > are added with this patch:
> > > - For the AMD (Xilinx) only, when a valid physical base address of
> > >    the device side DDR is not configured, then the IP can still be
> > >    used in non-LL mode. For all the channels DMA transactions will
> > >    be using the non-LL mode only. This, the default non-LL mode,
> > >    is not applicable for Synopsys IP with the current code addition.
> > >
> > > - If the default mode is LL-mode, for both AMD (Xilinx) and Synosys,
> > >    and if user wants to use non-LL mode then user can do so via
> > >    configuring the peripheral_config param of dma_slave_config.
> > >
> > > Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > Changes in v15
> > >     Rebased the branch
> > >
> > [snip]
> > > +
> > > +static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> > > +{
> > > +    struct dw_edma_chan *chan = chunk->chan;
> > > +
> > > +    if (chan->non_ll)
> >
> > Hi Devendra (cc: Frank),
> >
> > Sorry for dropping a comment now that this has already landed.
> >
> > I'm wondering about the lifetime of chan->non_ll. This patch lets a client
> > select non-LL mode through dma_slave_config.peripheral_config for a transfer,
> > but the state is stored on the channel.
> >
> > We use chan->non_ll in prep to choose bursts_max, then read it again later in
> > dw_hdma_v0_core_start() to choose the LL vs non-LL start path. If the channel is
> > reconfigured between prep and start, or before a later chunk is started from the
> > interrupt path, couldn't we start a descriptor in a different mode from the one
> > it was prepared for?
> >
>
> The mode is implemented with the intention that after prep, the
> submitted descriptor shall completed with the chosen mode. So, yes the
> mode is decided in the prep call and all the subsequent descriptors are
> completed with the chosen mode unless it is overridden by another prep
> call.
>
> > (Note: Frank's not-yet-merged dma_prep_config v7 series [1] also looks at
> > potential races around config+prep on the same channel from multiple process
> > contexts, as I understand it. But this seems like a separate issue, since the
> > state is read again at transfer start time.)
> >
> > Should non_ll be snapshotted into the descriptor/chunk, maybe as
> > dw_edma_desc.non_ll, or is the rule that clients must not reconfigure the
> > channel while anything is pending/running?
> >
>
> I am not aware of any such rule which specifies that modes can not be
> mixed but it would not be a good idea to mix both. Let me give an
> example, in the non-LL mode the channels *can* utilize the LL-regions
> for data transfers. If for such a non-LL data transfer where LL-region
> is used and intended by the user then changing the mode after setting up
> the mode to another one can cause data corruption.
>
> Eg:
> Channel LL-region = ADDR
> Mode set to non-LL -> DDR destination to ADDR to (ADDR + size)
> First non-LL burst -> writes data to ADDR till size bytes.
> Second burst configured for LL -> overwrites the data at ADDR with
> descriptor information.

I don't think we need mix LL and no-LL, previously config suppose only do
once before prepare and never change again.

But recently there are more user case to config for each prep. After [1]
merge, we can consider more. There should be no risk now if DMA consumer
don't change it during prepare.

Frank

>
> This one causes the data corruption for the first burst
>
>
> > Or was this already discussed, and there is some implicit restriction that
> > clients must not mix LL and temporary non-LL requests from multiple contexts on
> > the same channel?
> >
> > [1] https://lore.kernel.org/dmaengine/20260521-dma_prep_config-v7-0-1f73f4899883@nxp.com/
> >
> > Thanks,
> > Koichiro
> >
> > > +            dw_hdma_v0_core_non_ll_start(chunk);
> > > +    else
> > > +            dw_hdma_v0_core_ll_start(chunk, first);
> > > +}
> > > +
> > >   static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
> > >   {
> > >      struct dw_edma *dw = chan->dw;
> > > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > index eab5fd7177e5..7759ba9b4850 100644
> > > --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > @@ -12,6 +12,7 @@
> > >   #include <linux/dmaengine.h>
> > >
> > >   #define HDMA_V0_MAX_NR_CH                  8
> > > +#define HDMA_V0_CH_EN                               BIT(0)
> > >   #define HDMA_V0_LOCAL_ABORT_INT_EN         BIT(6)
> > >   #define HDMA_V0_REMOTE_ABORT_INT_EN                BIT(5)
> > >   #define HDMA_V0_LOCAL_STOP_INT_EN          BIT(4)
> > > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > > index 270b5458aecf..61d6064fcfed 100644
> > > --- a/include/linux/dma/edma.h
> > > +++ b/include/linux/dma/edma.h
> > > @@ -97,6 +97,7 @@ struct dw_edma_chip {
> > >      enum dw_edma_map_format mf;
> > >
> > >      struct dw_edma          *dw;
> > > +    bool                    cfg_non_ll;
> > >   };
> > >
> > >   /* Export to the platform drivers */
> > > --
> > > 2.43.0
> > >
>

