Return-Path: <dmaengine+bounces-8694-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LkuJPsogmnFPwMAu9opvQ
	(envelope-from <dmaengine+bounces-8694-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 17:57:31 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5273FDC618
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 17:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 59C563018BA8
	for <lists+dmaengine@lfdr.de>; Tue,  3 Feb 2026 16:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89813D1CCC;
	Tue,  3 Feb 2026 16:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KPJfMyG5"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013047.outbound.protection.outlook.com [52.101.83.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3B27FBAC;
	Tue,  3 Feb 2026 16:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770137582; cv=fail; b=IgUw82tPZBh36Ys6guibehEsYeTEtJvbngxp+/AaZmbH5yUmMqMlhaGM/nIoPIVMhpBcWFlQgBAFEHNElKc0jf1hxlRvb9/I9loWwcBVNA+SanCZfXyhNirZ7UBzDvc7PaI1LiG06RYR8cy/bdjGDqr3d3BleXBE2s6lhZeIN+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770137582; c=relaxed/simple;
	bh=nCHYN42XIkLeHBLzFE2eR1e1DZrmPUHw8CBkIMWOvRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UTcziJNSOW3r4K+sk4ZT3elJ2GHkJm6XRoXm3YbZJkN8wHg7yMBFiuR+WnN0eOyOC9+pvpPx/DfvYRogb0znsWn5sKwRHa1yv0W3nBYhtzDPQ1GyoG876u+DdlNOXFHAMOYpFi9PF3BbCFT5gYcPqV6bhsmPIGT+6h1dR6sR+P4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KPJfMyG5; arc=fail smtp.client-ip=52.101.83.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aagPVSlkQw6tyhlmUBxdHPb81oq7W7hR0ySyTkwKecFoT/WETf4b9qA5o1hi/7Habrzc2+kVxCCGFnOMPR4a5OT+zbSZhi2+7ys7PaMhlBImhbB6GEawiAZylpfpvq1akhKQfGUrowa7qs5aYSsfSWz8tfu8RvEdCtcC7j9j/F4iIV4dle37aPhky8sjdoYgnGaiYJZmoKTSgiusEvtXaRxly552rrZHmyPH52dCxvSC2suHrP4gVY8XKIiyIdtoRDMTmvyQiO+NaVoJxQzgDnUVN841oCoMrG4MZWxlVdk5hovrG+tVTRApoAzZI3g2/BgJse/TNCxKT/i6MOQbMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbwhpjSLmoCapNW+Fr0GS0XOXVv7OYElnT0zBmzul1g=;
 b=TRudnuKKSCIK3t1j/9mvmXNxzlQQ5H4zs5mSN6qJO/Tkct6nNe7yCdNzpKLEY85S6E4S2yc5XZvNyN+H4WU9fwVZ/Z+1+bL2Kj+0927W0ki1AaFjlhMom5VfHsAcrpfb7p3V5Vj5a1+ktITO1iLlsE/MrJ1iYiRa9WX8JK4Ge1yL4z2Ghhs87ncQm6E1OR/MhlpY9OnGTeXrgB5SqBT7OOOKLUqQgMR8UAyLcoHPm2ZPiagypiuvzgKC98q60qSoa/vIgbYf4TSdl1JevfKefDgC6RVbLBXXNN+4R7zZlBe8gTMtJ00oZNf+MiYsg6AJmu9eIO1I2gHU6H4G7BTXxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbwhpjSLmoCapNW+Fr0GS0XOXVv7OYElnT0zBmzul1g=;
 b=KPJfMyG5Ko4TaoQ8DmDypozijXBSn1D28VH13FlkdZ0LOGGFL2tWTE2aAM6bRb34DgUwyEPOUbZi5O6C0gl4is2xIWzmj6QOkr1QEHOKWBuxkTMFv0ItYfFXstLmNpysFB6gs07D6uLco3xyR+VEm8tvAJIzxaGtksl2ZyGXg95K1q9sdpshVGSWaK9PR6NQKWL9cN/bU6fg12kdnoLFNpZRCRsCGD3jnqfGnJu2QEr4QhnKmlu2l0Hks5KDxmy/dJG+QF35DlIQOXbHfpKoPHsEMvNy/bXaz9wcBXVJrpe6VXJDF5XbVeiE34sfy+ze53FTGW8BcP9KE3IA1F/NWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by PAXPR04MB8457.eurprd04.prod.outlook.com (2603:10a6:102:1d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 3 Feb
 2026 16:52:56 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 16:52:55 +0000
Date: Tue, 3 Feb 2026 11:52:48 -0500
From: Frank Li <Frank.li@nxp.com>
To: "Verma, Devendra" <Devendra.Verma@amd.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"mani@kernel.org" <mani@kernel.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>
Subject: Re: [PATCH v8 2/2] dmaengine: dw-edma: Add non-LL mode
Message-ID: <aYIn4PQioFJD7qzK@lizhi-Precision-Tower-5810>
References: <SA1PR12MB8120D7666CAF07FE3CAEC9619588A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aW5RmbQ4qIJnAyHz@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120F271FF381A78BEDCE6939589A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aXEKeojreN06HIdF@lizhi-Precision-Tower-5810>
 <SA1PR12MB81203BB877B64C4E525EC0269594A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aXe5ts7E6lUF7YRq@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120877E05B98E26B022C3669591A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aXomMjSgrCucF/De@lizhi-Precision-Tower-5810>
 <SA1PR12MB812089EE794D987D1AE48A07959EA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <SA1PR12MB8120CEA934BCA561FE860F0C959BA@SA1PR12MB8120.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR12MB8120CEA934BCA561FE860F0C959BA@SA1PR12MB8120.namprd12.prod.outlook.com>
X-ClientProxiedBy: BY3PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:a03:255::19) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|PAXPR04MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: d8e70e02-040a-4623-a99a-08de6344ad7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|1800799024|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tvkWgzjUNZg7C0rr70dGGU28hosEkXkiRC3rmBOW6vvzrBB/MFsRmgDelVnh?=
 =?us-ascii?Q?mwwrrftBPskiZULRdYsmjZPc+Kzb8wlp+mAgwgxzhyH7VG7i/XBGDYt8BvdG?=
 =?us-ascii?Q?XZ1ibhvfOTxXBf5XE2IbsdlCYPuMDUilevHJOUKHOnf+/g9cmNlU3yC+C5TT?=
 =?us-ascii?Q?OIYXJ55NM05fVNzBS23UnQMXpQmyCFOVDfAfs80yYgYBJQOQJhd0kwPQbrfa?=
 =?us-ascii?Q?mo9V41sln5vBNcwzDtmlfRG2X4SefAVWpyUjlW1FBmq9xi8ltRyR6Zae3pN9?=
 =?us-ascii?Q?FK+RmIZ0AmI1eo3q31aJoG63uYwMULZ6PN3AIsB4EV4VsuDd+v/THO7V4EGn?=
 =?us-ascii?Q?HkQ9iWfmneDRSkhbAu0Q8cxDjttxFAhLCw4DyKjfX7D0xWplJd/pQF81ztmb?=
 =?us-ascii?Q?fQ8Jbvv5NqumPD7sJMjIJso6cQyRweRUPfc8UPBVr5SBvVD2Ibh3oXchDJgU?=
 =?us-ascii?Q?hK3PTN44jPJcc9TcYlf5lFp3+5oAvz11uSXX5gDGXLupiccB889curAa/8Va?=
 =?us-ascii?Q?j8/3v5myy2Z0XLTYS6r1DGILbjOGErBuznaTcjvdbN4nIiUA7bzk3AaXwtQK?=
 =?us-ascii?Q?zRlZfGbWXkBsnWROVoFTwOEI/amFbw7GULtYTmDUVCSsgXylTKuqQ5wjlT/B?=
 =?us-ascii?Q?ceW8gvG3F1FwETZjK/t/XKcCMplT9KNiFF10JttNV5CTXm+L28OUoN50r8Tg?=
 =?us-ascii?Q?Gh6PgOLCtdlbzQpYUhOqdAVmspS48HZcyAT9/3Lw0xFfEVHy7PP2lD5QNCrJ?=
 =?us-ascii?Q?YwtKjrjJS6JsexSFTFJghLi35ZoKr4niqRXoxWOTZBrAvogfPZrf4DJFKDeU?=
 =?us-ascii?Q?RuGlggXenTPN3mZrowyt0ND5J4v9oM3ryQgsHtEbPHTetPoe2S9nUfyNH0AH?=
 =?us-ascii?Q?T8R0t2xbe3yPtG44LC79QY6tFxj2LYBVjeEyGFSeUrFAdua3DNTQ26hGr5fE?=
 =?us-ascii?Q?sDHdeIQAZ7AqyLd6vwZ/q6k4voRLDY1mYt9Uk9gMzC+NXaWOTEU3MYpbV7Jw?=
 =?us-ascii?Q?iPg3p0OP6HeBaZnUUw3Jbyt0S3VjCAD2wVp/KwhUL/68isIK/NpCv17Xku1j?=
 =?us-ascii?Q?3fYH2j9Qsyu6wTWgGRpkOYIQBSW7637RKfhAO6nex0wpKvHAGWDgcLCM9LbF?=
 =?us-ascii?Q?2MGSmp8HvylWKcL6TWpYGoKavF44dpf8reJPSz35MVmCNuQiZ8yf0+Jizxar?=
 =?us-ascii?Q?++CnsO4OmTWRhD6n9m4S1nv0j47nKhR7KPtHvudo1e8OhLHqT2VM8I4lgHlw?=
 =?us-ascii?Q?PcTECo0NGg4IQd7szywwFieGvee6P+K+9i35NpHtV/X1YopXVNNd+BrmTogB?=
 =?us-ascii?Q?XrjnyuEklxtlJkobtMppy2oLlRw7wG3yDxpUhvSeIUwxUVeIiGt58IxdeU4q?=
 =?us-ascii?Q?f4xteXdT4ve2Lbbx+VunFnMuU4cqmvwkTEguauYvOBSpOi4iYugTjoaWQ44S?=
 =?us-ascii?Q?XEHpMw4/b1xCc/kJyVIxyFCnlZo3Dse7QOtRCla0ILZR3skzCeD0K/KgZVAW?=
 =?us-ascii?Q?TdPaNpbBlyWgCnxlgG1FqlZVEqOjYHA1WPvufe123E43kfk/UiS8/reyNiOQ?=
 =?us-ascii?Q?bph/VRw5cWUoDitoQpYSNOPZjy7M8iVz/61jgRUr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(1800799024)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9QKSlHzLc54v+zd1KAIKTaj8eZBlHi577Qhcc6YaFMtKsJVURdm5m+4Uh//z?=
 =?us-ascii?Q?DQhx57qO/IW/cgn3pV4/e4tEfwlRWS2WeoAj5aqLFn2jKWEwztuijXupRstY?=
 =?us-ascii?Q?0UpbpIhJIV/QDdfvvF53J+5x9pCSR32yrZYxc1ojN9QZzpicC7e2SwDM9V0i?=
 =?us-ascii?Q?ekM4AY1cVD5rlwH5TaL9+OxCd8o9OIKO22Iq6oleXg1xtLIrij9ejg0OXimt?=
 =?us-ascii?Q?Fz/wXOBn+y07MVRFgSv30JpogChzIAPZHA9qQ7xhx2KItpk0edvGNHZ+nYVP?=
 =?us-ascii?Q?tXZV75Qls/R1JTAfs8egqmt7HoyocveCK3B59NbBAzsj1+JpI5JPyZFgqc5T?=
 =?us-ascii?Q?N1vuQNUZ4/vuHbNFHxAncFa9CoYjlFijHd3+jY1WSVImpYWjR/lzLkZ9vCB4?=
 =?us-ascii?Q?eMDPga9GhLNnAYKXxjZ9nK35jhkIsgDcb9RD7kvlkficREuQU4azepY7Myiv?=
 =?us-ascii?Q?IUu8ytLn9613yG6sKBrkRmV+1uHJ1VVrkBhZ6XWISNdEB1QQHMiw3UUkfk3q?=
 =?us-ascii?Q?WWe8q2+VcR5ZtYJlSbndTpIzooHqGTxIlFBjxzNCswzdxdaiIgeVfRN2yUp3?=
 =?us-ascii?Q?6JH1Xowi9lh7pjMwtkD8I3y//rq+wRLD5EEEHq5VuvlN8NqpOk7IErgWt1r/?=
 =?us-ascii?Q?UzuSyA/g9ghJh5FdFRUSJ40A+fDRHAUt0NkhFeI9oKPsR4XF/guUf+UCK5hI?=
 =?us-ascii?Q?jWGj6Et8r4I0NCSx0YNEyGDtSKrKeLB47xvAzgjlWQlmYkGMUAx6nVZywCzL?=
 =?us-ascii?Q?6+5nWI6A6OQaVLL5ew5dVq72FujCqXc+GKu0F7f5n3E7TfpPBXBPXTB+tXLw?=
 =?us-ascii?Q?eWIyFQRHy0ahiq/c7CHSr8DlMQwXNlZJKy7+zjB2TwruXpQG/XTahKEGtz/v?=
 =?us-ascii?Q?90EgInk2qC5pUOBdkPquM2hw6CyIefNbFiOJYf1WRqhwePHccOwXH5hBxSLb?=
 =?us-ascii?Q?4pDdExOSxsTT6HrIvCR22cG+4ipX5O0lvek9JngKgV6Asl8z/wPPZf8tYh5i?=
 =?us-ascii?Q?jXgJSMJp2Hz9wqqcWrW9t8CQwboeaJtM5E74wp74Sm3BNPYO5a4cxvGx4ev2?=
 =?us-ascii?Q?7usu7awuXu/8bftA9hAjW9BjRPp0qpaWP20CC9MadDkQn1wEBn6JHvxjjKLN?=
 =?us-ascii?Q?Rrkl1A+fCeAFRNO6SSzK3feXKoN2NjEKOPDMtvQazv9HIEM2fav4zKG2MghF?=
 =?us-ascii?Q?dOIa/XSzP+mDlToVCJa9rZKJAtQO/FjqLFNmPW4DcgFm+xGpx6rnwHorOBk0?=
 =?us-ascii?Q?i13LgQec/WRp3TDIju0KA2GyPIF87pQ2EdJkxmi0dNdC4Pic7DoD/9p0eUih?=
 =?us-ascii?Q?RwssqHK+8uIa64K91x03oz00mnNIM1kVa9hGBm8XVh1/Uoza5Hv2C27pNlZZ?=
 =?us-ascii?Q?hf4i0gz/cV1M6QTOh2L2Yu3puloPXF5Bs6IB+eAasgxSs88svI0fVbK1/Diy?=
 =?us-ascii?Q?CxjsTwHigXdF3VQL+j9w57rqViIyvePWgV5csuduJRZ7gxFQWk0kczk6qTVq?=
 =?us-ascii?Q?WswN04226b4A0j+MHn49iex4a0FTuMOY2T/y84pgr2Kcks1XyOL5yfdD5aXg?=
 =?us-ascii?Q?KqS1MmxE0LlKYkKtIf+yTIchs+cUs6Ra4B0TUQB5HKSURGfYAuxug51Id1mh?=
 =?us-ascii?Q?oifuG5oIyVggCZp23cmVQIWUSHRWC1YaNjgBc014RwMupi3/EsSm+7WNkjus?=
 =?us-ascii?Q?kTd2U0KHRJKtv+gM3B4+8Jz5GqXkVGyKv6LeVGBlmDOwKYCXLY9a+/C0bo7S?=
 =?us-ascii?Q?hlVfbIppsg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e70e02-040a-4623-a99a-08de6344ad7a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 16:52:55.7190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/nfjeXzToiRjcfazq+hap7ahip5/5rP73BEZaRSFgchjqf2QLSi1Fby/nxdyMJVU86h9kP9DbBMCQT9CA9Hmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8457
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8694-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 5273FDC618
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 12:03:54PM +0000, Verma, Devendra wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Frank
>
> Any update on this review?
>
> Regards,
> Devendra
>
> > -----Original Message-----
> > From: Verma, Devendra <Devendra.Verma@amd.com>
> > Sent: Thursday, January 29, 2026 5:26 PM
> > To: Frank Li <Frank.li@nxp.com>
> > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>; Verma,
> > Devendra <Devendra.Verma@amd.com>
> > Subject: RE: [PATCH v8 2/2] dmaengine: dw-edma: Add non-LL mode
> >
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > > -----Original Message-----
> > > From: Frank Li <Frank.li@nxp.com>
> > > Sent: Wednesday, January 28, 2026 8:38 PM
> > > To: Verma, Devendra <Devendra.Verma@amd.com>
> > > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > > Subject: Re: [PATCH v8 2/2] dmaengine: dw-edma: Add non-LL mode
> >
> > --[ Snipped some headers to reduce the size of this mail ]--
> >
> > > > > > > > > > > > AMD MDB IP supports Linked List (LL) mode as well as
> > > > > > > > > > > > non-LL
> > > > > mode.
> > > > > > > > > > > > The current code does not have the mechanisms to
> > > > > > > > > > > > enable the DMA transactions using the non-LL mode.
> > > > > > > > > > > > The following two cases are added with this patch:
> > > > > > > > > > > > - For the AMD (Xilinx) only, when a valid physical
> > > > > > > > > > > > base
> > > address of
> > > > > > > > > > > >   the device side DDR is not configured, then the IP can still
> > be
> > > > > > > > > > > >   used in non-LL mode. For all the channels DMA
> > > > > > > > > > > > transactions will
> > > > > > > > > > >
> > > > > > > > > > > If DDR have not configured, where DATA send to in
> > > > > > > > > > > device side by non-LL mode.
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > The DDR base address in the VSEC capability is used for
> > > > > > > > > > driving the DMA transfers when used in the LL mode. The
> > > > > > > > > > DDR is configured and present all the time but the DMA
> > > > > > > > > > PCIe driver uses this DDR base address (physical
> > > > > > > > > > address) to configure the LLP
> > > > > address.
> > > > > > > > > >
> > > > > > > > > > In the scenario, where this DDR base address in VSEC
> > > > > > > > > > capability is not configured then the current controller
> > > > > > > > > > cannot be used as the default mode supported is LL mode only.
> > > > > > > > > > In order to make the controller usable non-LL mode is
> > > > > > > > > > being added which just needs SAR, DAR, XFERLEN and
> > > > > > > > > > control register to initiate the transfer. So, the DDR
> > > > > > > > > > is always present, but the DMA PCIe driver need to know
> > > > > > > > > > the DDR base physical address to make the transfer. This
> > > > > > > > > > is useful in scenarios where the memory
> > > > > > > > > allocated for LL can be used for DMA transactions as well.
> > > > > > > > >
> > > > > > > > > Do you means use DMA transfer LL's context?
> > > > > > > > >
> > > > > > > >
> > > > > > > > Yes, the device side memory reserved for the link list to
> > > > > > > > store the descriptors, accessed by the host via BAR_2 in
> > > > > > > > this driver
> > > code.
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > >   be using the non-LL mode only. This, the default
> > > > > > > > > > > > non-LL
> > > mode,
> > > > > > > > > > > >   is not applicable for Synopsys IP with the current
> > > > > > > > > > > > code
> > > addition.
> > > > > > > > > > > >
> > > > > > > > > > > > - If the default mode is LL-mode, for both AMD
> > > > > > > > > > > > (Xilinx) and
> > > > > Synosys,
> > > > > > > > > > > >   and if user wants to use non-LL mode then user can
> > > > > > > > > > > > do so
> > > via
> > > > > > > > > > > >   configuring the peripheral_config param of
> > > dma_slave_config.
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Devendra K Verma
> > > > > > > > > > > > <devendra.verma@amd.com>
> > > > > > > > > > > > ---
> > > > > > > > > > > > Changes in v8
> > > > > > > > > > > >   Cosmetic change related to comment and code.
> > > > > > > > > > > >
> > > > > > > > > > > > Changes in v7
> > > > > > > > > > > >   No change
> > > > > > > > > > > >
> > > > > > > > > > > > Changes in v6
> > > > > > > > > > > >   Gave definition to bits used for channel configuration.
> > > > > > > > > > > >   Removed the comment related to doorbell.
> > > > > > > > > > > >
> > > > > > > > > > > > Changes in v5
> > > > > > > > > > > >   Variable name 'nollp' changed to 'non_ll'.
> > > > > > > > > > > >   In the dw_edma_device_config() WARN_ON replaced
> > > > > > > > > > > > with
> > > > > > > dev_err().
> > > > > > > > > > > >   Comments follow the 80-column guideline.
> > > > > > > > > > > >
> > > > > > > > > > > > Changes in v4
> > > > > > > > > > > >   No change
> > > > > > > > > > > >
> > > > > > > > > > > > Changes in v3
> > > > > > > > > > > >   No change
> > > > > > > > > > > >
> > > > > > > > > > > > Changes in v2
> > > > > > > > > > > >   Reverted the function return type to u64 for
> > > > > > > > > > > >   dw_edma_get_phys_addr().
> > > > > > > > > > > >
> > > > > > > > > > > > Changes in v1
> > > > > > > > > > > >   Changed the function return type for
> > > > > dw_edma_get_phys_addr().
> > > > > > > > > > > >   Corrected the typo raised in review.
> > > > > > > > > > > > ---
> > > > > > > > > > > >  drivers/dma/dw-edma/dw-edma-core.c    | 42
> > > > > > > > > +++++++++++++++++++++---
> > > > > > > > > > > >  drivers/dma/dw-edma/dw-edma-core.h    |  1 +
> > > > > > > > > > > >  drivers/dma/dw-edma/dw-edma-pcie.c    | 46
> > > > > > > ++++++++++++++++++--
> > > > > > > > > ------
> > > > > > > > > > > >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 61
> > > > > > > > > > > > ++++++++++++++++++++++++++++++++++-
> > > > > > > > > > > >  drivers/dma/dw-edma/dw-hdma-v0-regs.h |  1 +
> > > > > > > > > > >
> > > > > > > > > > > edma-v0-core.c have not update, if don't support, at
> > > > > > > > > > > least need return failure at dw_edma_device_config()
> > > > > > > > > > > when backend is
> > > > > eDMA.
> > > > > > > > > > >
> > > > > > > > > > > >  include/linux/dma/edma.h              |  1 +
> > > > > > > > > > > >  6 files changed, 132 insertions(+), 20 deletions(-)
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > > > > > > b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > > > > > > index b43255f..d37112b 100644
> > > > > > > > > > > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > > > > > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > > > > > > @@ -223,8 +223,32 @@ static int
> > > > > > > > > > > > dw_edma_device_config(struct
> > > > > > > > > > > dma_chan *dchan,
> > > > > > > > > > > >                                struct dma_slave_config *config)  {
> > > > > > > > > > > >       struct dw_edma_chan *chan =
> > > > > > > > > > > > dchan2dw_edma_chan(dchan);
> > > > > > > > > > > > +     int non_ll = 0;
> > > > > > > > > > > > +
> > > > > > > > > > > > +     if (config->peripheral_config &&
> > > > > > > > > > > > +         config->peripheral_size != sizeof(int)) {
> > > > > > > > > > > > +             dev_err(dchan->device->dev,
> > > > > > > > > > > > +                     "config param peripheral size mismatch\n");
> > > > > > > > > > > > +             return -EINVAL;
> > > > > > > > > > > > +     }
> > > > > > > > > > > >
> > > > > > > > > > > >       memcpy(&chan->config, config,
> > > > > > > > > > > > sizeof(*config));
> > > > > > > > > > > > +
> > > > > > > > > > > > +     /*
> > > > > > > > > > > > +      * When there is no valid LLP base address
> > > > > > > > > > > > + available then the
> > > > > > > default
> > > > > > > > > > > > +      * DMA ops will use the non-LL mode.
> > > > > > > > > > > > +      *
> > > > > > > > > > > > +      * Cases where LL mode is enabled and client
> > > > > > > > > > > > + wants to use the
> > > > > > > non-LL
> > > > > > > > > > > > +      * mode then also client can do so via
> > > > > > > > > > > > + providing the
> > > > > > > peripheral_config
> > > > > > > > > > > > +      * param.
> > > > > > > > > > > > +      */
> > > > > > > > > > > > +     if (config->peripheral_config)
> > > > > > > > > > > > +             non_ll = *(int
> > > > > > > > > > > > + *)config->peripheral_config;
> > > > > > > > > > > > +
> > > > > > > > > > > > +     chan->non_ll = false;
> > > > > > > > > > > > +     if (chan->dw->chip->non_ll ||
> > > > > > > > > > > > + (!chan->dw->chip->non_ll &&
> > > > > > > non_ll))
> > > > > > > > > > > > +             chan->non_ll = true;
> > > > > > > > > > > > +
> > > > > > > > > > > >       chan->configured = true;
> > > > > > > > > > > >
> > > > > > > > > > > >       return 0;
> > > > > > > > > > > > @@ -353,7 +377,7 @@ static void
> > > > > > > > > > > > dw_edma_device_issue_pending(struct
> > > > > > > > > > > dma_chan *dchan)
> > > > > > > > > > > >       struct dw_edma_chan *chan =
> > > > > > > > > > > > dchan2dw_edma_chan(xfer-
> > > > > > > >dchan);
> > > > > > > > > > > >       enum dma_transfer_direction dir = xfer->direction;
> > > > > > > > > > > >       struct scatterlist *sg = NULL;
> > > > > > > > > > > > -     struct dw_edma_chunk *chunk;
> > > > > > > > > > > > +     struct dw_edma_chunk *chunk = NULL;
> > > > > > > > > > > >       struct dw_edma_burst *burst;
> > > > > > > > > > > >       struct dw_edma_desc *desc;
> > > > > > > > > > > >       u64 src_addr, dst_addr; @@ -419,9 +443,11 @@
> > > > > > > > > > > > static void dw_edma_device_issue_pending(struct
> > > > > > > > > > > dma_chan *dchan)
> > > > > > > > > > > >       if (unlikely(!desc))
> > > > > > > > > > > >               goto err_alloc;
> > > > > > > > > > > >
> > > > > > > > > > > > -     chunk = dw_edma_alloc_chunk(desc);
> > > > > > > > > > > > -     if (unlikely(!chunk))
> > > > > > > > > > > > -             goto err_alloc;
> > > > > > > > > > > > +     if (!chan->non_ll) {
> > > > > > > > > > > > +             chunk = dw_edma_alloc_chunk(desc);
> > > > > > > > > > > > +             if (unlikely(!chunk))
> > > > > > > > > > > > +                     goto err_alloc;
> > > > > > > > > > > > +     }
> > > > > > > > > > >
> > > > > > > > > > > non_ll is the same as ll_max = 1. (or 2, there are
> > > > > > > > > > > link back
> > > entry).
> > > > > > > > > > >
> > > > > > > > > > > If you set ll_max = 1, needn't change this code.
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > The ll_max is defined for the session till the driver is
> > > > > > > > > > loaded in the
> > > > > > > kernel.
> > > > > > > > > > This code also enables the non-LL mode dynamically upon
> > > > > > > > > > input from the DMA client. In this scenario, touching
> > > > > > > > > > ll_max would not be a good idea as the ll_max controls
> > > > > > > > > > the LL entries for all the DMA channels not just for a
> > > > > > > > > > single DMA
> > > transaction.
> > > > > > > > >
> > > > > > > > > You can use new variable, such as ll_avail.
> > > > > > > > >
> > > > > > > >
> > > > > > > > In order to separate out the execution paths a new
> > > > > > > > meaningful variable
> > > > > > > "non_ll"
> > > > > > > > is used. The variable "non_ll" alone is sufficient. Using
> > > > > > > > another variable along side "non_ll" for the similar purpose
> > > > > > > > may not have any
> > > > > > > added advantage.
> > > > > > >
> > > > > > > ll_avail can help debug/fine tune how much impact preformance
> > > > > > > by adjust ll length. And it make code logic clean and consistent.
> > > > > > > also ll_avail can help test corner case when ll item small.
> > > > > > > Normall case it is
> > > > > hard to reach ll_max.
> > > > > > >
> > > > > >
> > > > > > Thank you for your suggestion. The ll_max is max limit on the
> > > > > > descriptors that can be accommodated on the device side DDR. The
> > > > > > ll_avail
> > > > > will always be less than ll_max.
> > > > > > The optimization being referred can be tried without even having
> > > > > > to declare the ll_avail cause the number of descriptors given
> > > > > > can be controlled by the DMA client based on the length argument
> > > > > > to the
> > > > > dmaengine_prep_* APIs.
> > > > >
> > > > > I optimzied it to allow dynatmic appended dma descriptors.
> > > > >
> > > > > https://lore.kernel.org/dmaengine/20260109-edma_dymatic-v1-0-
> > > > > 9a98c9c98536@nxp.com/T/#t
> > > > >
> > > > > > So, the use of dynamic ll_avail is not necessarily required.
> > > > > > Without increasing the ll_max, ll_avail cannot be increased. In
> > > > > > order to increase ll_max one may need to alter size and
> > > > > > recompile this
> > > driver.
> > > > > >
> > > > > > However, the requirement of ll_avail does not help for the
> > > > > > supporting the
> > > > > non-LL mode.
> > > > > > For non-LL mode to use:
> > > > > > 1) Either LL mode shall be not available, as it can happen for the Xilinx
> > IP.
> > > > > > 2) User provides the preference for non-LL mode.
> > > > > > For both above, the function calls are different which can be
> > > > > > differentiated by using the "non_ll" flag. So, even if I try to
> > > > > > accommodate ll_avail, the call for LL or non-LL would be
> > > > > > ambiguous as in
> > > > > case of LL mode also we can have a single descriptor as similar to
> > > > > non-LL mode.
> > > > > > Please check the function dw_hdma_v0_core_start() in this review
> > > > > > where the decision is taken Based on non_ll flag.
> > > > >
> > > > > We can treat ll_avail == 1 as no_ll mode because needn't set extra
> > > > > LL in memory at all.
> > > > >
> > > >
> > > > I analyzed the use of ll_avail but I think the use of this variable
> > > > does not fit at this location in the code for the following reasons:
> > > > 1. The use of a new variable breaks the continuity for non-LL mode.
> > > > The
> > > variable
> > > >     name non_ll is being used for driving the non-LL mode not only
> > > > in this file
> > > but also
> > > >    in the files relevant to HDMA. This flag gives the clear
> > > > indication of LL vs
> > > non-LL mode.
> > > >    In the function dw_hdma_v0_core_start(), non_ll decided the mode
> > > > to
> > > choose.
> > > > 2. The use of "ll_avail" is ambiguous for both the modes. First, it
> > > > is
> > > associated with LL mode only.
> > > >      It will be used for optimizing / testing the Controller
> > > > performance based
> > > on the
> > > >     number of descriptors available on the Device DDR side which is
> > > > for LL
> > > mode. So when
> > > >     it is being used for LL mode then it is obvious that it excludes
> > > > any use for
> > > non-LL mode.
> > > >     In the API dw_edma_device_transfer(), the ll_avail will be used
> > > > for
> > > creating the bursts.
> > > >     If ll_avail = 1 in the above API, then it is ambiguous whether
> > > > it is creating
> > > the burst for
> > > >      LL or non-LL mode. In the above API, the non_ll is sufficient
> > > > to have the
> > > LL mode
> > > >      and non-LL burst allocation related piece of code.
> > >
> > > If really like non-ll, you'd better set ll_avail = 1 in prepare code.
> > > Normal case ll_avail should be ll_max. It will reduce if-else branch
> > > in prep dma burst code.
> > >
> >
> > I think we are not on the same page, and it is creating confusion.
> > If non_ll flag is being used to differentiate between the modes, then in this
> > scenario the use of ll_avail does not fit any requirement related to
> > differentiation of different modes. In the last response, I pointed out that
> > ll_avail, if used, creates ambiguity rather than bringing clarity for both LL &
> > non-LL mode. If non_ll flag is used and initialized properly then this is
> > sufficient to drive the execution for non-LL mode.
> >
> > In the function doing the preparation, there also no if-else clause is
> > introduced rather the same "if" condition is extended to support the non-LL
> > mode.
> >
> > Could you elaborate what is the approach using ll_avail if I need to maintain
> > the continuity of the non-LL context and use non-LL mode without any
> > ambiguity anywhere, instead of using non_ll flag?
> > If possible, please give a code snippet. Depending upon the usability and
> > issue it fixes, I will check its feasibility.
> >
> > > +               /*
> > > +                * For non-LL mode, only a single burst can be handled
> > > +                * in a single chunk unlike LL mode where multiple bursts
> > > +                * can be configured in a single chunk.
> > > +                */
> > >
> > > It is actually wrong, current software should handle that. If there
> > > are multiple bursts, only HEAD of bursts trigger DMA, in irq handle,
> > > it will auto move to next burst. (only irq latency is bigger compared
> > > to LL, software's resule is the same).
> > >
> > > The code logic is totally equal ll_max = 1, except write differece registers.
> > >
> >
> > Changing the ll_max dynamically for a single request is not feasible. As
> > pointed out earlier it may require the logic to retain the initially configured
> > value, during the probe, and then use the retained value depending on the
> > use-case.

As my previous suggest, add ll_avail, config can set it in [1..ll_max].
then replace ll_max with ll_avail.

> > Could you elaborate the statement,
> > " The code logic is totally equal ll_max = 1, except write differece registers." ?

My means don't touch actual logic in dw_edma_device_transfer() except
change ll_max to ll_avail or other variable, with value 1.

Even though you really want to use non_ll, you can use below code

dw_edma_device_transfer()
{

	size_t avail = no_ll ? 1 : ll_max;
	...

	if (chunk->bursts_alloc == avail)
	...
}

> >
> > The irq_handler() for success case calls dw_edma_start_transfer() which
> > schedules the chunks not bursts.

Current code, it is that. I forget I just change it.

>  The bursts associated with that chunk will
> > get written to controller DDR area / scheduled (for non-LL) in the
> > dw_hdma_v0_core_start(), for HDMA.

Original code have unnecessary complex about chunks and burst, which actually
add overhead.

See my patch to reduce 2 useless malloc()

https://lore.kernel.org/dmaengine/20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com/

> > With this flow, for the non-LL mode each chunk needs to contain a single
> > burst as controller can handle only one burst at a time in non-LL mode.

Non-LL case, you just fill one. The only difference is fill to DDR or
registers.

Frank

> >
> >
> > > And anthor important is that,
> > >
> > > in dw_edma_device_config() should return if backend is not HDMA.
> > >
> >
> > Thanks, this is a valid concern, will address in the upcoming version.
> >
> > > Frank
> > >
> > > >
> > > > I think ll_avail, if used for trying out to optimize / debug the
> > > > settings related to number of descriptors for LL mode then it should
> > > > be part of the separate discussion / update not related to non-LL.
> > > >
> > > > > >
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > ...
> > > > > > > > > > > > +
> > > > > > > > > > > > + ll_block->bar);
> > > > > > > > > > >
> > > > > > > > > > > This change need do prepare patch, which only change
> > > > > > > > > > > pci_bus_address() to dw_edma_get_phys_addr().
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > This is not clear.
> > > > > > > > >
> > > > > > > > > why not. only trivial add helper patch, which help
> > > > > > > > > reviewer
> > > > > > > > >
> > > > > > > >
> > > > > > > > I was not clear on the question you asked.
> > > > > > > > It does not look justified when a patch is raised alone just
> > > > > > > > to replace this
> > > > > > > function.
> > > > > > > > The function change is required cause the same code *can*
> > > > > > > > support different IPs from different vendors. And, with this
> > > > > > > > single change alone in the code the support for another IP
> > > > > > > > is added. That's why it is easier to get the reason for the
> > > > > > > > change in the function name and
> > > > > syntax.
> > > > > > >
> > > > > > > Add replace pci_bus_address() with dw_edma_get_phys_addr() to
> > > > > > > make review easily and get ack for such replacement patches.
> > > > > > >
> > > > > > > two patches
> > > > > > > patch1, just replace exist pci_bus_address() with
> > > > > > > dw_edma_get_phys_addr() patch2, add new logic in
> > > > > dw_edma_get_phys_addr() to support new vendor.
> > > > > > >
> > > > > >
> > > > > > I understand your concern about making the review easier.
> > > > > > However, given that we've been iterating on this patch series
> > > > > > since September and are now at v9, I believe the current
> > > > > > approach is justified. The function renames from
> > > > > > pci_bus_address() to dw_edma_get_phys_addr() is directly tied to
> > > > > > the non-LL mode functionality being added - it's needed because
> > > > > > the same code now supports different IPs from different vendors.
> > > > > >
> > > > > > Splitting this into a separate preparatory patch at this stage
> > > > > > would further delay the review process. The change is kind of
> > > > > > straightforward and the context is clear within the current patch.
> > > > > > I request
> > > > > you to review this patch to avoid additional review cycles.
> > > > > >
> > > > > > This also increases the work related to testing and maintaining
> > > > > > multiple
> > > > > patches.
> > > > > > I have commitment for delivery of this, and I can see adding one
> > > > > > more series definitely add 3-4 months of review cycle from here.
> > > > > > Please excuse me but this code has already
> > > > >
> > > > > Thank you for your persevere.
> > > > >
> > > >
> > > > Thank you for your support.
> > > >
> > > > > > been reviewed extensively by other reviewers and almost by you
> > > > > > as well. You can check the detailed discussion wrt this function
> > > > > > at the following
> > > > > link:
> > > > > >
> > > > >
> > >
> > https://lore.kernel.org/all/SA1PR12MB8120341DFFD56D90EAD70EDE9514A@
> > > > > SA1
> > > > > > PR12MB8120.namprd12.prod.outlook.com/
> > > > > >
> > > > >
> > > > > But still not got reviewed by tags. The recently,  Manivannan
> > > > > Sadhasivam , Niklas Cassel and me active worked on this driver.
> > > > > You'd better to get their feedback. Bjorn as pci maintainer to
> > > > > provide
> > > generally feedback.
> > > > >
> > > >
> > > > Hi Manivannan Sadhasivam, Vinod Koul and Bjorn Helgaas Could you
> > > > please provide your feedback on the patch?
> > > > You have reviewed these patches extensively on the previous versions
> > > > of
> > > the same series.
> > > >
> > > > Regards,
> > > > Devendra
> > > >
> > > > >
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > >               ll_region->paddr += ll_block->off;
> > > > > > > > > > > >               ll_region->sz = ll_block->sz;
> > > > > > > > > > > >
> > > > > > > ...
> > > > > > > > > > > >
> > > > > > > > > > > > +static void dw_hdma_v0_core_non_ll_start(struct
> > > > > > > > > > > > +dw_edma_chunk
> > > > > > > > > > > *chunk)
> > > > > > > > > > > > +{
> > > > > > > > > > > > +     struct dw_edma_chan *chan = chunk->chan;
> > > > > > > > > > > > +     struct dw_edma *dw = chan->dw;
> > > > > > > > > > > > +     struct dw_edma_burst *child;
> > > > > > > > > > > > +     u32 val;
> > > > > > > > > > > > +
> > > > > > > > > > > > +     list_for_each_entry(child,
> > > > > > > > > > > > + &chunk->burst->list,
> > > > > > > > > > > > + list) {
> > > > > > > > > > >
> > > > > > > > > > > why need iterated list, it doesn't support ll. Need
> > > > > > > > > > > wait for irq to start next
> > > > > > > > > one.
> > > > > > > > > > >
> > > > > > > > > > > Frank
> > > > > > > > > >
> > > > > > > > > > Yes, this is true. The format is kept similar to LL mode.
> > > > > > > > >
> > > > > > > > > Just fill one. list_for_each_entry() cause confuse.
> > > > > > > > >
> > > > > > > > > Frank
> > > > > > > >
> > > > > > > > I see, we can use list_first_entry_or_null() which is
> > > > > > > > dependent on giving the type of pointer, compared to this
> > > > > > > > list_for_each_entry() looks neat and agnostic to the pointer
> > > > > > > > type being used. Though, it can be
> > > > > > > explored further.
> > > > > > > > Also, when the chunk is allocated, the comment clearly
> > > > > > > > spells out how the allocation would be for the non LL mode
> > > > > > > > so it is evident that each chunk would have single entry and
> > > > > > > > with that understanding it is clear that loop will also be
> > > > > > > > used in a similar manner, to retrieve a single entry. It is
> > > > > > > > a similar use case as of "do {}while (0)" albeit needs a
> > > > > > > > context to
> > > > > > > understand it.
> > > > > > >
> > > > > > > I don't think so. list_for_each_entry() is miss leading to
> > > > > > > reader think it is not only to one item in burst list, and use
> > > > > > > polling method to to finish many burst transfer.
> > > > > > >
> > > > > > > list_for_each_entry() {
> > > > > > >         ...
> > > > > > >         readl_timeout()
> > > > > > > }
> > > > > > >
> > > > > > > Generally, EDMA is very quick, polling is much quicker than
> > > > > > > irq if data is
> > > > > small.
> > > > > > >
> > > > > > > Frank
> > > > > > >
> > > > > >
> > > > > > The polling is not required. The single burst will raise the
> > > > > > interrupt and from the interrupt context another chunk will be
> > > > > > scheduled. This cycle repeats till all the chunks with single
> > > > > > burst are
> > > exhausted.
> > > > > >
> > > > > > The following comment made in function dw_edma_device_transfer()
> > > > > > in the same patch makes it amply clear that only a single burst
> > > > > > would be
> > > > > handled for the non-LL mode.
> > > > > > +       /*
> > > > > > +        * For non-LL mode, only a single burst can be handled
> > > > > > +        * in a single chunk unlike LL mode where multiple bursts
> > > > > > +        * can be configured in a single chunk.
> > > > > > +        */
> > > > > >
> > > > > > Looking at the way bursts are appended to chunks and chunks in
> > > > > > dw_edma_device_transfer() are scheduled for non-LL mode then it
> > > > > > is clear
> > > > > what non-LL mode would handle in terms of bursts.
> > > > > > I just kept the format to match it with the LL mode format
> > > > > > otherwise there is no need of this comment and we can follow the
> > > > > > syntax for a single
> > > > > entry alone.
> > > > > > Please share your suggestion if these descriptions fail to
> > > > > > provide the clear
> > > > > context and intent.
> > > > >
> > > > > Avoid use list_for_each_entry() here to prevent miss-leading.
> > > > >
> > > > > Frank
> > > > >
> > > >
> > > > Sure, thanks, I will push this change in next version.
> > > >
> > > > > >
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id,
> > > > > > > > > > > > + ch_en, HDMA_V0_CH_EN);
> > > > > > > > > > > > +
> > > > > > > > > > > > +             /* Source address */
> > > > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id, sar.lsb,
> > > > > > > > > > > > +                       lower_32_bits(child->sar));
> > > > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id, sar.msb,
> > > > > > > > > > > > +                       upper_32_bits(child->sar));
> > > > > > > > > > > > +
> > > > > > > > > > > > +             /* Destination address */
> > > > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id, dar.lsb,
> > > > > > > > > > > > +                       lower_32_bits(child->dar));
> > > > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id, dar.msb,
> > > > > > > > > > > > +                       upper_32_bits(child->dar));
> > > > > > > > > > > > +
> > > > > > > > > > > > +             /* Transfer size */
> > > > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id,
> > > > > > > > > > > > + transfer_size,
> > > > > > > > > > > > + child->sz);
> > > > > > > > > > > > +
> > > > > > > > > > > > +             /* Interrupt setup */
> > > > > > > > > > > > +             val = GET_CH_32(dw, chan->dir,
> > > > > > > > > > > > + chan->id, int_setup)
> > > |
> > > > > > > > > > > > +                             HDMA_V0_STOP_INT_MASK |
> > > > > > > > > > > > +                             HDMA_V0_ABORT_INT_MASK |
> > > > > > > > > > > > +
> > > > > > > > > > > > + HDMA_V0_LOCAL_STOP_INT_EN |
> > > > > > > > > > > > +
> > > > > > > > > > > > + HDMA_V0_LOCAL_ABORT_INT_EN;
> > > > > > > > > > > > +
> > > > > > > > > > > > +             if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL)) {
> > > > > > > > > > > > +                     val |= HDMA_V0_REMOTE_STOP_INT_EN |
> > > > > > > > > > > > +                            HDMA_V0_REMOTE_ABORT_INT_EN;
> > > > > > > > > > > > +             }
> > > > > > > > > > > > +
> > > > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id,
> > > > > > > > > > > > + int_setup, val);
> > > > > > > > > > > > +
> > > > > > > > > > > > +             /* Channel control setup */
> > > > > > > > > > > > +             val = GET_CH_32(dw, chan->dir, chan->id, control1);
> > > > > > > > > > > > +             val &= ~HDMA_V0_LINKLIST_EN;
> > > > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id,
> > > > > > > > > > > > + control1, val);
> > > > > > > > > > > > +
> > > > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id, doorbell,
> > > > > > > > > > > > +                       HDMA_V0_DOORBELL_START);
> > > > > > > > > > > > +     }
> > > > > > > > > > > > +}
> > > > > > > > > > > > +
> > > > > > > > > > > > +static void dw_hdma_v0_core_start(struct
> > > > > > > > > > > > +dw_edma_chunk *chunk, bool
> > > > > > > > > > > > +first) {
> > > > > > > > > > > > +     struct dw_edma_chan *chan = chunk->chan;
> > > > > > > > > > > > +
> > > > > > > > > > > > +     if (chan->non_ll)
> > > > > > > > > > > > +             dw_hdma_v0_core_non_ll_start(chunk);
> > > > > > > > > > > > +     else
> > > > > > > > > > > > +             dw_hdma_v0_core_ll_start(chunk,
> > > > > > > > > > > > + first); }
> > > > > > > > > > > > +
> > > > > > > > > > > >  static void dw_hdma_v0_core_ch_config(struct
> > > > > > > > > > > > dw_edma_chan
> > > > > > > > > > > > *chan)
> > > > > > > > > {
> > > > > > > > > > > >       struct dw_edma *dw = chan->dw; diff --git
> > > > > > > > > > > > a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > > > > > > > > > b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > > > > > > > > > index eab5fd7..7759ba9 100644
> > > > > > > > > > > > --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > > > > > > > > > +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > > > > > > > > > @@ -12,6 +12,7 @@
> > > > > > > > > > > >  #include <linux/dmaengine.h>
> > > > > > > > > > > >
> > > > > > > > > > > >  #define HDMA_V0_MAX_NR_CH                    8
> > > > > > > > > > > > +#define HDMA_V0_CH_EN                                BIT(0)
> > > > > > > > > > > >  #define HDMA_V0_LOCAL_ABORT_INT_EN           BIT(6)
> > > > > > > > > > > >  #define HDMA_V0_REMOTE_ABORT_INT_EN          BIT(5)
> > > > > > > > > > > >  #define HDMA_V0_LOCAL_STOP_INT_EN            BIT(4)
> > > > > > > > > > > > diff --git a/include/linux/dma/edma.h
> > > > > > > > > > > > b/include/linux/dma/edma.h index 3080747..78ce31b
> > > > > > > > > > > > 100644
> > > > > > > > > > > > --- a/include/linux/dma/edma.h
> > > > > > > > > > > > +++ b/include/linux/dma/edma.h
> > > > > > > > > > > > @@ -99,6 +99,7 @@ struct dw_edma_chip {
> > > > > > > > > > > >       enum dw_edma_map_format mf;
> > > > > > > > > > > >
> > > > > > > > > > > >       struct dw_edma          *dw;
> > > > > > > > > > > > +     bool                    non_ll;
> > > > > > > > > > > >  };
> > > > > > > > > > > >
> > > > > > > > > > > >  /* Export to the platform drivers */
> > > > > > > > > > > > --
> > > > > > > > > > > > 1.8.3.1
> > > > > > > > > > > >
>

