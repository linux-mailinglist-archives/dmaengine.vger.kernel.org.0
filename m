Return-Path: <dmaengine+bounces-8620-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLenFeDPfGlbOwIAu9opvQ
	(envelope-from <dmaengine+bounces-8620-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 16:36:00 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB0DBC134
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 16:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF5F8300DD74
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 15:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922A033031C;
	Fri, 30 Jan 2026 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PRfahCM4"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010045.outbound.protection.outlook.com [52.101.84.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F48322A;
	Fri, 30 Jan 2026 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769787356; cv=fail; b=FA0+ulElXv/8Kgw6iwer7j83dGhytqNFSA9jq/6s1Sb1D1ejuwJDRZ2a/k76IG4xcxnq5FtCWrQQdQORg4XZ+3gvadcMGISVHNe0cL1zgRBrSxa+ZtxllPVRPKJGRrgKder3qnFcNQm9bd6YPHTU6fgOC8UdmUN/Yw8r+xW3Xwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769787356; c=relaxed/simple;
	bh=CiwTH7IEllmjjBy/sroCBZkknvAqedWmub2JTIEnEL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tik5TteHU+tKgupRbYoXpY96RXeYFwsDQ0hje6PGLXYfKQ+mFvEQIN/CuHcsXNEnW4e8q5Q7LBoKcPhz+J1GTO+b4N1hEJIouXvKi5xZhrJsQOPfwNV443aIPddvOVR1bk/evhLtQVuoTD5A3Lo1H3W48ShD5gsP8C35xH0PaYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PRfahCM4; arc=fail smtp.client-ip=52.101.84.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VscJ0c19S3okYQXu99v191ryQQ7V725cRi11uqiy1Ixm12B4/UqtMGBmUygMdnClzbFIH1R9eAapwoaQxZNIunKUrbqvBC84GEjjoa1yUNk/J7kbRfTDm8CTuTF4Ey4HL6ykW6sk863wjIV7gLvKLaJ6fUOrp5iSTQe7RStQKXhy7HKDhDiCTRVlOIeDLFukkmaizU5nmHKhc8cSGTCRub+phFxQUcgfzrA2YY75XIWV1mGZDiSi51hMsCoGAk6zXI1Oi9yvIwlZ6pvhRluc4r/aV/z9CTNlji6Ia9Rjx/Og8SjyhH0/ImZQbJ8L2HUohJAXBiJRJ8XlcfNAfY6ELA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ULI9+srsSxK1DV2k9hNeHg9FgXLhXmByrsrefOEEPs=;
 b=jw4w5Cd/KuQPfNpUPpwMv80J+X3HoulYPq1dprIUt3THoGENOKy02/Ih+ybMpq9TQ/FpigOB879JjfrizzKYu5oR3KYywtlbY/bhPghWuxo4HNUfeyAYd91KYaSEDCnspxLhvcxV+ua0mRre/m/uncgpf+O6o5cYTqeWdVKXwBSxrQNlibh94cc+rD9K49wnty1A9uiJhGVRdSyiHa4+8va9zCM2dqsmU57BR19TQgt0cRGQ30fcDDDYaR+yEl9K6eiMCbIfk/Xc4eGWmVF0NtM+NXtSduAJd7a0KKVzqUT19mceZp2+nvwdoFjpX85LOsPbjhhcdBvH62S6jCbWuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ULI9+srsSxK1DV2k9hNeHg9FgXLhXmByrsrefOEEPs=;
 b=PRfahCM4AdnJ/hUGbZxOVBcu+FBeHGQuMcgUehASBECsA67fAqkT5Gnq277LOsOM2ukGCkWIPfsNpswb+UuuRUO7KbY8fhoGFFul3PVUOpTw5fA9pJwNxE+gXk4COOCUuON7BPhVtDPPsA+4d76NRMj5DFAbHdbhJpvnONe7/jzW8zCnxnH8RoNN0DqX97D8sCrAlUEd+4XyKaKDNjza0QpQRoXS78J1Bf6XA7DNA6T0wJqTAzKIkbJs9Jslwe0qjPJeobPpYsFEH26pO6oqG4Pvx2q8umhvsvUHcvwK2WZXzI6zsIN3kpC0YL9ZRqZ2h3ioDljUfXX0xdldBf6EQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI1PR04MB9811.eurprd04.prod.outlook.com (2603:10a6:800:1d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 15:35:51 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 15:35:51 +0000
Date: Fri, 30 Jan 2026 10:35:43 -0500
From: Frank Li <Frank.li@nxp.com>
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>
Cc: peter.ujfalusi@gmail.com, vkoul@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, nm@ti.com,
	ssantosh@kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, vigneshr@ti.com,
	r-sharma3@ti.com, gehariprasath@ti.com
Subject: Re: [PATCH v4 12/19] dt-bindings: dma: ti: Add K3 BCDMA V2
Message-ID: <aXzPz/Kq1d7i1iWM@lizhi-Precision-Tower-5810>
References: <20260130110159.359501-1-s-adivi@ti.com>
 <20260130110159.359501-13-s-adivi@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130110159.359501-13-s-adivi@ti.com>
X-ClientProxiedBy: PH2PEPF00003850.namprd17.prod.outlook.com
 (2603:10b6:518:1::72) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI1PR04MB9811:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a3b28a2-05d2-49e2-b44e-08de60153fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|52116014|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ac632sEh/qfQSUOJyiOuFXux8tB7ItBp/mpXbPnGecmnfwJo+AGa9HHZh5a5?=
 =?us-ascii?Q?Swxz0Xi/J4YBMGn4UgJztTStvNhN+UqPtCBbqMAfqURkt+QuJ86kFJMxMX8b?=
 =?us-ascii?Q?HFprSfevP4tlwMbT7kNUIeZsbftOk+RhqNh4rd/bQM1yBNrd7qe13yCfmD8n?=
 =?us-ascii?Q?I81Eizl+BHk2SWwXspk3qKi2iE/mTXgByYivWVt6XuQfYpVlK7nM0z1jhxgK?=
 =?us-ascii?Q?CmFsURSeliO4SosunBVMgdCx12RBKcyzBe7rGytdRp7zoK4Yoqwt5uWAUPa0?=
 =?us-ascii?Q?rZtH6Fhzs5uQEj9qRDRp89f9hn5ANHfq+EjldOL18UdqwHwdxgncG88E/BU2?=
 =?us-ascii?Q?ucUUqoaCOPJ/mEcer1Ur2Bl//MinjWUyu/Y9XcxEZyVv4e4xBmzHSXIuR0kk?=
 =?us-ascii?Q?Q0RWSfiWl+Cg7KX4mbea1GEaQlT3r1O2samrRoPK/lFBhFoOyODfV3WE4VaM?=
 =?us-ascii?Q?xZEjgTSFPJTcoCJH9E59IpUQixcZs5KGhSVeSOYu/eM28/Eh+ZX/r2u61a16?=
 =?us-ascii?Q?AmH4EKoVLFSzKSe3vG0x6bTSsDpbDTrW5tZxU5yapRfSqu2YCyYDDIgYEbQ1?=
 =?us-ascii?Q?xlt1ZVvTWDzrVwJyTCoCEAaYNAzkq8Pckj3xRopkm0nCLNaIU6qWL0XbDxEp?=
 =?us-ascii?Q?IxQkfJEChTJ1FGYvIslZbKhNGX9B3ZfopGVuKntAKO4wzyxdYqGvYyv02oY7?=
 =?us-ascii?Q?MJLsvs2cbaMPeNvrJ4RLDMv/sWAkztQIajTxs97rCtrzuL2td8QOMnVKt1zq?=
 =?us-ascii?Q?uxFv+uKJKIiFzGK0rYxmDwARg8BfSrDV6HbLb4i8cL3TYJBU8KJ/vQTgRDzz?=
 =?us-ascii?Q?XuXmJu9iuAILphlq2m/LbiHyN+0Aml0XTymxGHPs84pD8tAyEkl1k3xCTJO2?=
 =?us-ascii?Q?ERhx67rA63Um6qjtioqaEQfmn0YvdiNNp9APAmM7vruTKfKBtGFBSYH9jftE?=
 =?us-ascii?Q?IgopT/U9MskaM73aj6ZwPXgeg7JncbeGVnyp8kZF2XH68TxVTgGalb+efa+q?=
 =?us-ascii?Q?EpoXV8k5uUWyFu9cGCSj+TaMOZph1uH5u5f8DlB2H2MrZLMStK75HQSxDDH7?=
 =?us-ascii?Q?+dLCBDar0vUvDfMrL/HOjkZuU8Eq55TD7/NyeVXMtKH1K6Xjx+PYDpac43Pf?=
 =?us-ascii?Q?5MhMuMSP3KPAsHjQQ1Oym7bYfR6pNsyeDFPHE5ilsGgmMBCZFW/eZFnfWr6+?=
 =?us-ascii?Q?Ov4HSCnqN26Lct6HKelY8//OX7lCzl1lc9mkm2RWDgT27eYZ9LL3Q8SuG3ID?=
 =?us-ascii?Q?TRrPPVjOCPb5vrEHlc2r0roO1GYq9yVwo6L4/t9kt6AI3VXfLnsUGvfLhSK2?=
 =?us-ascii?Q?HLHDA8VqBvDi9JiNiPs4PPz9Sr7cyITGQaydreVHfFjy7LnupKtqgIEeAzFb?=
 =?us-ascii?Q?9QHcS5Pzln6daAzaq/T97k+Hr98n4W8ycwHwQ0VKdZyjNWeEOj29JgLUpiTK?=
 =?us-ascii?Q?y8LXOBzqQMVvZP6JY9/fALr+PClxVqU21vJM2jRM57c63t4sd6yFHzOsm6bU?=
 =?us-ascii?Q?AssKBo5Y/LFB/8w6U222MR4Jk5zBDWIHvT35xYCHidhwsWrPD74CTzC9Yc+n?=
 =?us-ascii?Q?cRdJnv4+6HHr1+BuJcag/T3c871dRrakebApoHgb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(52116014)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eWsTERWQ0IvayEr+o97o6gOCW08foGzsZO79SfJflHBbS6vTgARDQ3UQ24L+?=
 =?us-ascii?Q?Krr2cYurX6IVRTsx1DeGQtH/QIbKmcHt2yyvpV+HEG0npw1n2iHYO6o+VFDv?=
 =?us-ascii?Q?pentee0lami6IDZXzP3pIZH/xt1KUzwATHvJhyJvnlRMdGsibCHbkWQReI55?=
 =?us-ascii?Q?H2VkCSpJsbRR4qEqxV10PTfVV6D7jsKDELcLqwVScTSWdstGutgoTlGBxud7?=
 =?us-ascii?Q?jbjvHOzLdYIpb/BmJPXYUN80wPLsnqEot7Mh8vhMxoKhKEiweST48keczZSU?=
 =?us-ascii?Q?jfvwSCSnmddTs/FDMJzNQxWJthg3RluYqxwPwj7uHugcpeScYolMYnnWFMXr?=
 =?us-ascii?Q?Ct5wgpEnDarLx9dWsRTJZ5DauUq+KNuezgRJ1vd3vxAoR89zx68ZIN8ybHd9?=
 =?us-ascii?Q?vzKKwHVazT2YcuuL1JVtPdAMQqyTvK9nau52zk1x9jgGB2NYbIOTjxNUm8Sj?=
 =?us-ascii?Q?TIzzJ3Rsp8+P6l5AIIoT3ODEa6u4NLa3iOt+LbhuZvBiSyReCMktKQTOvH0i?=
 =?us-ascii?Q?89EBYJhY+4vfcMAc5mn4pjDz4oa0oUkvUiwVMl1kSOt/SiCx0kTgnTDgiRu5?=
 =?us-ascii?Q?f9wLfE50wIg6ku8XIftdBOq7kBm2DMC0BV/4ZkEbvdCVF3OReDEITEdyU2p6?=
 =?us-ascii?Q?a3BwZZPrLLIQSPZqH78e6JdovHZSuz6jsrXmETEdopY2w9Xs7KaXb/JjvKxV?=
 =?us-ascii?Q?NxtRrRNQZ3oz8vIUJYmJA8vQWSVglIAiQ5kcDamXoHx9+EUygVBqgJ4fh8DY?=
 =?us-ascii?Q?Zc8sN6Q3gI3vjvBHf55Ue4ZUhsjblRSInAl+9m8Nz5Hx1ehQ3eKjAtXabVxD?=
 =?us-ascii?Q?tpW5VQ+wC/TP+ppFFHq57IW1OVJuCzZ4n4gJkRHn78EjSoCt4rNVDV/48VFw?=
 =?us-ascii?Q?IbxJR9TrgtN+LgqvZMNmWbLRIxfZ0l1S8TfesVnHcPZVHl9Y9Kv3JhQ0suxe?=
 =?us-ascii?Q?eH9LLRGMAkf6QD45WBMYPlljNdtGBcN1gss5JFAXzz1VR0KKGMnTvyQp8wWL?=
 =?us-ascii?Q?uRTd+JgVYv1d6npUwx9aeQYg8FZarLSp6Ts6X9tv14nmg5fGIn+5uahqNYge?=
 =?us-ascii?Q?O4K/pfQHc/QX3Zt6AYi1D4p67vTl6Iu1xZyG0nI6fe10qLop4kqcOtRKlDdy?=
 =?us-ascii?Q?1p4EO1N2zszpwpHRRwcZfDF9V4IJFdEg05c1U4rZp7Iox2AqnLxAFcsW2JQJ?=
 =?us-ascii?Q?gDsAACLk4EcD1sPghpJHk7iz//Bvr9yr0Wp7cRu2UBYrbevrxXl4sTV5ElNT?=
 =?us-ascii?Q?xY7LmmuZ5EYvIl7RkUhd+QZgjZQ/XofjIVLPBSpgZgdjF41VKmMkwYy+pPuG?=
 =?us-ascii?Q?Fi/PiMcHH2iec8x3Q4dSpmCxF2nOmUcMYLcC9hujmUHKMygSEi9Q0ok/dB/9?=
 =?us-ascii?Q?ABxtgmrI2P/aAuLdPeEX9T+fW1qwKUO/bDtG6/CU7KS79A+d0WXXT4DRluM4?=
 =?us-ascii?Q?UKeocafFsiEb0o5ExMUE4+EspKymhIi09ws0NsLW3uVaxwh3duPEYVdXx5eG?=
 =?us-ascii?Q?KmAp/gXxkKDr+KmhsJzO8ifqFphMkAU7fA88c1n5uJW1ro8Kzlz9uzApDy43?=
 =?us-ascii?Q?CCT8zR9bDr4o7XXxkxwpK+doeLLdTotxZ2DIJErTT2ZSQvVKtRCZprdaZMH7?=
 =?us-ascii?Q?lkYnf//bOQiXM0IT5bSwJ3HDCHFzgRh9GlH5B8tYuKwYwEvGSOWPAHwWDswd?=
 =?us-ascii?Q?lRXcjr5H5Mqe9GYyng787oWIqiIr0sXzvev1hE5Eh7ffff0aQlfqt2j9tzJn?=
 =?us-ascii?Q?eTrUtZ4lng=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3b28a2-05d2-49e2-b44e-08de60153fe3
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 15:35:51.7876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p950VfXPX5J/il97xZS5jq+oOnwY8JsfNRH6rKynbusa9EUw+eaCDG8V/NFi+Ed8On7Ja4z3Yi+Sk6EZj2ZLLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9811
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8620-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,devicetree.org:url,ti.com:email,485c4000:email,2.110.143.0:email]
X-Rspamd-Queue-Id: BCB0DBC134
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 04:31:52PM +0530, Sai Sree Kartheek Adivi wrote:
> New binding document for
> Texas Instruments K3 Block Copy DMA (BCDMA) V2.
>
> BCDMA V2 is introduced as part of AM62L.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
>  .../bindings/dma/ti/ti,k3-bcdma-v2.yaml       | 116 ++++++++++++++++++
>  1 file changed, 116 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/ti/ti,k3-bcdma-v2.yaml
>
> diff --git a/Documentation/devicetree/bindings/dma/ti/ti,k3-bcdma-v2.yaml b/Documentation/devicetree/bindings/dma/ti/ti,k3-bcdma-v2.yaml
> new file mode 100644
> index 0000000000000..b0bfb19ba863a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/ti/ti,k3-bcdma-v2.yaml
> @@ -0,0 +1,116 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2024-2025 Texas Instruments Incorporated
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/ti/ti,k3-bcdma-v2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments K3 DMSS BCDMA V2
> +
> +maintainers:
> +  - Sai Sree Kartheek Adivi <s-adivi@ti.com>
> +
> +description: |
> +  The BCDMA V2 is intended to perform similar functions as the TR mode channels
> +  of K3 UDMA-P. BCDMA V2 includes block copy channels and Split channels.
> +
> +  Block copy channels mainly used for memory to memory transfers, but with
> +  optional triggers a block copy channel can service peripherals by accessing
> +  directly to memory mapped registers or area.
> +
> +  Split channels can be used to service PSI-L based peripherals. The peripherals
> +  can be PSI-L native or legacy, non PSI-L native peripherals with PDMAs. PDMA
> +  is tasked to act as a bridge between the PSI-L fabric and the legacy peripheral.
> +
> +allOf:
> +  - $ref: /schemas/dma/dma-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: ti,am62l-dmss-bcdma
> +
> +  reg:
> +    items:
> +      - description: BCDMA Control /Status
> +      - description: Block Copy Channel Realtime
> +      - description: Channel Realtime
> +      - description: Ring Realtime
> +
> +  reg-names:
> +    items:
> +      - const: gcfg
> +      - const: bchanrt
> +      - const: chanrt
> +      - const: ringrt
> +
> +  "#dma-cells":
> +    const: 4

look like only this difference compare v3. can you consider to combine to
one file

Frank
> +    description: |
> +      cell 1: Channel operation mode
> +        0 - split channel / no trigger
> +        1 - internal channel event
> +        2 - external signal
> +        3 - timer manager event
> +
> +      cell 2: parameter for the trigger:
> +        if cell 1 is 0 (disable / no trigger):
> +          Unused, ignored
> +        if cell 1 is 1 (internal channel event):
> +          channel number whose TR event should trigger the current channel.
> +        if cell 1 is 2 or 3 (external signal or timer manager event):
> +          index of global interfaces that come into the DMA.
> +
> +          Please refer to the device documentation for global interface indexes.
> +
> +      cell 3: Channel identification for the peripheral
> +        if cell 1 is 0 (split channel / no trigger):
> +          PSI-L thread ID of the remote (to BCDMA) end.
> +          Valid ranges for thread ID depends on the data movement direction:
> +          for source thread IDs (rx): 0 - 0x7fff
> +          for destination thread IDs (tx): 0x8000 - 0xffff
> +
> +          Please refer to the device documentation for the PSI-L thread map and
> +          also the PSI-L peripheral chapter for the correct thread ID.
> +
> +        if cell 1 is 1 or 2 or 3 (MEM_TO_MEM and/or trigger type):
> +          Unused, provide 0.
> +
> +      cell 4: ASEL value for the channel
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - "#dma-cells"
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    main {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        main_bcdma: dma-controller@485c4000 {
> +            compatible = "ti,am62l-dmss-bcdma";
> +            reg = <0x00 0x485c4000 0x00 0x4000>,
> +                  <0x00 0x48880000 0x00 0x10000>,
> +                  <0x00 0x48800000 0x00 0x80000>,
> +                  <0x00 0x47000000 0x00 0x200000>;
> +            reg-names = "gcfg", "bchanrt", "chanrt", "ringrt";
> +            #dma-cells = <4>;
> +        };
> +
> +        crypto@40800000 {
> +            compatible = "ti,am62l-dthev2";
> +            reg = <0x00 0x40800000 0x00 0x14000>;
> +
> +            dmas = <&main_bcdma 0 0 0x4700 0>,
> +                   /* rx: Split channel, no trigger, PSI-L thread id, ASEL value */
> +                   <&main_bcdma 0 0 0xc701 0>,
> +                   /* tx1: Split channel, no trigger, PSI-L thread id, ASEL value */
> +                   <&main_bcdma 0 0 0xc700 0>;
> +                   /* tx2: Split channel, no trigger, PSI-L thread id, ASEL value */
> +            dma-names = "rx", "tx1", "tx2";
> +        };
> +    };
> --
> 2.34.1
>

