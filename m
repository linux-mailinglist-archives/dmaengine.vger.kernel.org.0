Return-Path: <dmaengine+bounces-11518-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Jg/4EtfWL2oGHwUAu9opvQ
	(envelope-from <dmaengine+bounces-11518-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 12:41:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9167E685652
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 12:41:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=windriver.com header.s=PPS06212021 header.b=AZUYjSIw;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11518-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11518-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=windriver.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C53BE303F288
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 10:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639332F8EB0;
	Mon, 15 Jun 2026 10:41:01 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CAE339705;
	Mon, 15 Jun 2026 10:40:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781520061; cv=fail; b=qnklgdacxgTz4l26nyf/mHE0WEsLXciwgvwZ+DMY4Rgufc8742QAgHKd5T5fusXELxa1HsOUqwM6PuinW+pk60//gOJ86qOlEQnQR0FRrXjPD5EDTnKYJWug5juVggw+FGeBrYGMX6b3s8IdFDk75N5Mf6Ww5uSOEndjYonIYgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781520061; c=relaxed/simple;
	bh=ARLjsdvZi/+Ftlkw23KnwYHMmk7clPEzYZ+87htCHmU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Bgtk4G/NoXh+j1oN/yeWBZuNYv61kJ0diVuBRDOlBtaesyfYY34+1G0LE+SR1Q8pXTs9aXExiCHzWefHEPyUfb6iPT5JGj6HsAimmTV4bZ1Q1hCmg4c4+mGE9baiwo9rIqP3XCzeevjYIlyTNJai/qpIQqu8I4YKiJS2crQsBXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=AZUYjSIw; arc=fail smtp.client-ip=205.220.166.238
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FAd3uG1038723;
	Mon, 15 Jun 2026 03:40:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=bFNo3SHpC
	GEqZm2VlJFB0P0O5p9zUPFTImkabEeIfLs=; b=AZUYjSIw8rWUzA/0VD7ulmvWq
	06wAknVIYG4l9SPhqXOLqVvQlBN/JWgc8LoCO6pMAv6jtnugxPz/QL1wG7wM4qb0
	Cgl4JEQT+TitW9SMWgdEtuhnJPw50e9M4Hd/si4b/91CR6QmY3ZseVUkDUqklkjZ
	GvO/zcdmdctMMwE2TDdJjU2W1RLWerSELBXBKWuwxeSsuf4duN4ICLB2fg5z1FRk
	7QPZfEaUtq+VzTWrnpwqsAi1ay0TCHw5WzWssCZlLON1bzSHemsZ45swiIMzgPQw
	FmD6U//U3saHDMLgGDDDdk20KRRlzIPdvaRrB99A74vAHExvq9RANSIIhGTDg==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011066.outbound.protection.outlook.com [52.101.62.66])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4es6qdt2db-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 03:40:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1B5RFOYiRjdekAVYUXkACepxXMjNotI/y6zO0igXiS0f91aO/YGLL94U10qqWRYvLCMT5vDb6L4LhHHuOWKJ1nFo31jAvRozAdKcggVsN2hgdiXO4cPj8IKCnPECMRp939krfV2H0lhK1tza9t/g62sjQ2LIaSmjBL1Cz4NRREhj72dgOk+S6rnsdCt93Djy6WJXi+nhNwp64tGY89N7asnHfSbSd93KaSNLmV2VYjkOJ4QaZJ5oVaYsBqKAyjuLPqynmFMHrWmnJRP4SXrRpTkVoYsETZ3kW4KUP+bIO7Rm8JWoFraVKfiL3IHOISzuuNmfjkFhih62EPX7Jx+Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFNo3SHpCGEqZm2VlJFB0P0O5p9zUPFTImkabEeIfLs=;
 b=v25PohrrhtELMsF/UPbVn6oKVGtod40TGwKL1rc+SIVHMFHQqz470b+NEIKmfsL3pyM84gjLunvD5KlS0S45T/2BggOgdWva1sg/hUnziXJf8aQ5FlbGirYu8GrumzrCZZbvnvmlCcgCTyIMEVPZVo1OLu9ujQsxtl7OdvNVxslOQwabGq0guNVSt0kivawGNhPY5ST7wV5WHN93zvXXwNYC2eE9GR9ZlfzrLXEY7Ck+z1UU8J8vtXp78ve+fJQd3mrUATxppOMMXra+pzaBWxP5r01UO7p3+xUUAY9DhC+kMR0FCXl806AmnTthwtPUkVJa4EZMPGtR2IIWw7Tdog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BYAPR11MB3606.namprd11.prod.outlook.com (2603:10b6:a03:b5::25)
 by DS0PR11MB8161.namprd11.prod.outlook.com (2603:10b6:8:164::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 10:40:00 +0000
Received: from BYAPR11MB3606.namprd11.prod.outlook.com
 ([fe80::6b12:513c:c6c1:42ca]) by BYAPR11MB3606.namprd11.prod.outlook.com
 ([fe80::6b12:513c:c6c1:42ca%3]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 10:40:00 +0000
From: "Bogdan Codres (Wind River)" <bogdan.codres@windriver.com>
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: vkoul@kernel.org, dave.jiang@intel.com, vinicius.gomes@intel.com,
        xueshuai@linux.alibaba.com, yi.sun@intel.com, fenghuay@nvidia.com,
        dan.carpenter@linaro.org, gregkh@linuxfoundation.org,
        stable@vger.kernel.org
Subject: [PATCH] dmaengine: idxd: fix use-after-free in idxd_free() and idxd_alloc() error paths
Date: Mon, 15 Jun 2026 13:39:31 +0300
Message-ID: <20260615103932.61828-1-bogdan.codres@windriver.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0053.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::42) To BYAPR11MB3606.namprd11.prod.outlook.com
 (2603:10b6:a03:b5::25)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3606:EE_|DS0PR11MB8161:EE_
X-MS-Office365-Filtering-Correlation-Id: a1a99029-a9be-4d0c-4573-08decaca7327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|23010399003|376014|18002099003|38350700014|56012099006|3023799007|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	vMYgxKfF9aP6e631Uvv19cVfz/P9IZA1hN6ITJxILtKkFb2FlTh9p01JnmRDB34gCNl3B9UGG0eUf2VjI/y5ZciP283ND8stxCT0tjnzmA+qwQnfm0gLHfTgbK65if4T8UdZ8nrMurk/+n3NhOV/6F2KezZqvD01uM6Zsu09F2SZCyGB7KyyXby5ql9K3hkyjhjqP4zQDk7wTZqhWjwJpDLt+y8iS118IkCVwKYbC4mVWNcLBkNWE2xiMRMLX65igmsZNj18xp/xcnSn0gg1P2sjiFNC6F3TOT/5ZYgZw2DeZriCevrmiUKMvBDFr/2klUW3lfuBSqSqVNelSOANMqCApIHc/xvirw8hhw7vQUFePyWhN5PG8Hc9mLC7IDYhRIZ+t4MA4jvD5oBYbqVh4CeDRFxQek7a5L0Iu4YA6m4a+8vrNOlbS53Ygm0XznmhkyaXMqdFFa0vbu7y9/U+YRCDZJgWLdpQhr2gNlA7JE+0wWv0BSWRaeUjc9VIN10bycCcR8WWkebo2j1kRhvGqbm38ccjoRMwJRhAHBPA1C6RgLTfdPSAmEuuirrxwn0KUjS7n6gDt65UO/5hymzHvAetgVyvcGqxuGGVm6ZmyX2HFajwV+zHNRMqVW6lnm8WRiKO8M5eAG1fMC7XdKXJD3mB+yR1xTU1nw4+qr8AFil4aEjJvETxNFCI6rAkjFmrx+drwpStu2H2e8r6FSgE5lMplE4PyOqrpse2Vfxu3hD0iWLngqfl30F6qi7rG+sQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3606.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(23010399003)(376014)(18002099003)(38350700014)(56012099006)(3023799007)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LCU8Bn2rAT27UEdll0K0Qtm2qpSGQJneOabcbRItsQGlzdOiylp8d6WtQh51?=
 =?us-ascii?Q?rV4KVP9Rh80y66oOcWnS8mWN7e5PEdQpbiXaRH4XVCnjisGM+P3l7FrEO1En?=
 =?us-ascii?Q?DL9OzWzKD4q2Bal5eEhkY/kaN2TUNAHcZUBuzGg6rmxA/Mcct47nKwD/VKFi?=
 =?us-ascii?Q?UWXnkpdSVKW0GyFUqaDErzaKF1ndS0PNOpE5xQcFcx6uqpnkP9wvjkDrjO4r?=
 =?us-ascii?Q?fW/nrqrN15JcOyTjPvAs12bbjoMnu3zXOZErtUk94fS1oBHVxdeIoa0C3yNt?=
 =?us-ascii?Q?16Y+qnXMJ9ChOBijChTmPtkcPL597B4ZpIxgNgQwCTV8mmxdjo2chmIhSrO6?=
 =?us-ascii?Q?IUI9hGq1Cl+BKr8ukDAT6qOwqZyO2CNdHcQ0YQycBhDHvA8gYPyop1T7YKBG?=
 =?us-ascii?Q?3sLZMOKaCImObtbWnsnM1ko7usiWUdkKXfOq/hGPq4sfgBT9b9ghg8ge3B/B?=
 =?us-ascii?Q?0G0vRguSZVmLwdTaouC+ta07gbLSA3OXfJyP2BrVpGaWE0RnhfazMj6f2fzO?=
 =?us-ascii?Q?myPjNX5i4sb4JuFAmpeYQrtOE0ajd/YhAomlRZbjGJkDdzzWQb2SoDynIKmd?=
 =?us-ascii?Q?yTZCreuJfIyFNJTF9TPNb6BtfQEwfrl6aQW9NeDvi8UmG7r4zEeWcbFInhOS?=
 =?us-ascii?Q?XKnIrzvw8SEfUEITG1LmESPYX9NOs96//8j/SjzlSDWc7OVNzTFWnOZu7Ls0?=
 =?us-ascii?Q?cHAfzxPEZCSQFVC8N/+RhU6XMbTrNJAt/aa7ZJdKkK6oyKcbosm49eUodIdw?=
 =?us-ascii?Q?jsOYpmzB+AFLb4ESjYJDmcssAycXFAu6VMjNu+u0knaFXXp1SAm2NzVPUe9d?=
 =?us-ascii?Q?8kHLox6ZiVbIwMZS1nsZBVdVy+etDPDVR4ps20FgJvQKr9u4DbyjShUwEVxg?=
 =?us-ascii?Q?gL6CZYdJGMU6ACyr3nG36ph+ZFJAe1/5IFDpeGcRpXpx6vY6B2NGIAxtvTN9?=
 =?us-ascii?Q?fL6WxtfCDBZB71CkC3ONys+aSkc5d03Fvm8HETTFuZBxrba4otAOervDnXnO?=
 =?us-ascii?Q?Q0iuFj6JODHEYOXvRFrpkkOZ61QGc4s4JK+Pd6vQtMQ877KXVESYNk0tn95J?=
 =?us-ascii?Q?mbid1je7ZDaaQzFex2U1JO7St3D0fx6Spz52f563T1RU1pnw3vy0wHAOXA5r?=
 =?us-ascii?Q?ZpyUoMNBU903O+rhc2F3HSaAd/4X1278GOX4sHIw53KLvLHZecS/Li4T31rI?=
 =?us-ascii?Q?PI83zLm8SapHT2FzdPLA30KLwv5LGfs1VGVfrjLwu2ZwxOfpguJhKGLC3LdX?=
 =?us-ascii?Q?A4J8WkyJ4BwOPpIzBdO5iUq/L0uMWgEF3ZgA3XBv3TpVHw2p8M4cMqo8ixsr?=
 =?us-ascii?Q?d2HaiRIL0cjO8P0dh94bgYNw2iwRhfzfoLcjlPp2UhGFK1WHWbEIZrTCGI5K?=
 =?us-ascii?Q?lzrDA7KoD5vqGqUBrZ/Lx2MJPFsM9x0eAW1XwUVt4CbvVJD1ZKPWFYZKcpPr?=
 =?us-ascii?Q?EDiCqIViRZeLJdSTdxDKkF/FjyDC+ttnlTvUuMh2svGxIKnEWB5jcs1yTzZa?=
 =?us-ascii?Q?dmsE/zAKfcAkkdG9P5Z02jSVpqlnK+edHjs2tLCEA0OBWjP42VmVo4AZGqTT?=
 =?us-ascii?Q?VjXtIirjRWagrlj6YOtUn6hjFUb4lvhqXPhpRQxisDrHUPdC7gqvEdCDKHLb?=
 =?us-ascii?Q?h/C120JFuamGac2A9lgeXT9bJurQvrELO3Nkzqol8gQLrqZ5/Duj5h7EgjBJ?=
 =?us-ascii?Q?rpU9Ajx4A38RXTAKsByv2QossEzLOv7b1tnujAFsiWHx1WgO1fWwOjcOsMit?=
 =?us-ascii?Q?3msdzWKsQUOyJtsptK2qTI0aMOwhQ0E=3D?=
X-Exchange-RoutingPolicyChecked:
	rfu27pJCuBQnToBItmYqb/Qtf6R2EHak2fen+FsQaxg71JcnGltpgqc6Mg0yWenaKWU7eAMpAN1b+vTjHWCUBcCaZcMNPuCYXtRDUud2EU7gQuBgsoalYpLzpQzAiBiGud9CV7CQoT46Wpc9JVQCh6YhbugWd1RlLLBfK+LpmHUuhrxbxhE/UoMeWYsKxHNxbIWZm5snl2HQRwb0U/2DXDKj0O3VK4xkKgq5yWauxNIszcmoiWcWRjBNk7uTZtJwDDJQYBJabszA+wwRqVMTPV25sfcMe1QZbpldEFgc5DgW0tfcmudMoxDCX5F0ZIs6LX550SNTKdPEwqW59OII1g==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a99029-a9be-4d0c-4573-08decaca7327
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3606.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 10:40:00.2637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LJsiSAzdbf30baWyKS29UEElw5Fyv8i3VSWSs0OS08eIu/QtS9lf0uI9OF/Kll8iq3fMTt+HSl5eKOXVGQd26q4xWVCYZ61cmK0A21OFNzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8161
X-Authority-Analysis: v=2.4 cv=DLq/JSNb c=1 sm=1 tr=0 ts=6a2fd682 cx=c_pps
 a=OANxLEngf0bc/nxW+UjZ1w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=SRrdq9N9AAAA:8 a=Ikd4Dj_1AAAA:8 a=KKAkSRfTAAAA:8
 a=ag1SF4gXAAAA:8 a=GELfJQfxpZnB2HLHRscA:9 a=cvBusfyB2V15izCimMoJ:22
 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-GUID: fA-3DCYFuLBiKhnj40bST-qjV38rFNjQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDExMSBTYWx0ZWRfX6M4GEyIrpbeB
 GANP9jWsq9XwTx0YkDKpRZsaOzOCwJaUWhYKqgd1WBplgYkKoh7onh6h9MpXWH8AU6A1ld3MoXi
 Pj3b2tq7vOolIuBfY7URg30vm4VyhKeVypTUX+DkB4thE7VT4Bh3XOhevd5rBJxU2gMviDxIBo7
 Acyd7K6aNuBF/XmCSr5ALKMl/qLalCKjQaeXagGen3m6OtYUfj5Y58IMMSFiL1B+ziXfcDcVqQJ
 cwETVUU4jQ5KFY8vYjlZkHoZvmNEVa9utOOVwcyFBCodLwympx45bAny+nikmhA2VL6jYv9ITUM
 9D6WKCdm5z3Qb4eOHyj1PHTo6HdUV/4EipKaJP60dQOy1d/68jglxByUOUQh6wDvKwK0g+EepBZ
 +2f3xLdincUIQDpwN6xA+SJf5N02DGai9q/FbL1F4vETbXsU74W9U0zyTWNmqWmB1bwlIHVbgiC
 6L5e6gZb3X41zvutlRw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDExMSBTYWx0ZWRfX0zQd2jsufp5/
 tYSOMHXAR7fKQAqBG8p7AxGHa1qvGvYvjocCgq2jBvLjop5YYDE2ycce8yERPyLxeP4bWcf96AI
 eqgaOqL3tFCijrYTH/bB3Qexb1I5onH3vFqTe+a4BRbdsWEG+ePX
X-Proofpoint-ORIG-GUID: fA-3DCYFuLBiKhnj40bST-qjV38rFNjQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11518-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[bogdan.codres@windriver.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vkoul@kernel.org,m:dave.jiang@intel.com,m:vinicius.gomes@intel.com,m:xueshuai@linux.alibaba.com,m:yi.sun@intel.com,m:fenghuay@nvidia.com,m:dan.carpenter@linaro.org,m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bogdan.codres@windriver.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:email,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,alibaba.com:email,linaro.org:email];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9167E685652

To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
    Dave Jiang <dave.jiang@intel.com>,
    Vinicius Costa Gomes <vinicius.gomes@intel.com>,
    Shuai Xue <xueshuai@linux.alibaba.com>,
    Yi Sun <yi.sun@intel.com>,
    Fenghua Yu <fenghuay@nvidia.com>,
    Dan Carpenter <dan.carpenter@linaro.org>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    stable@vger.kernel.org

Hi,

This patch fixes a double-free / use-after-free bug in the IDXD driver's
probe error path that corrupts the slab allocator and crashes the kernel.
The bug was introduced by commit 90022b3a6981 ("dmaengine: idxd: fix memory
leak in error handling path of idxd_pci_probe") which added the idxd_free()
helper.

Root Cause
----------

idxd_free() performs:

  static void idxd_free(struct idxd_device *idxd)
  {
      if (!idxd)
          return;
      put_device(idxd_confdev(idxd));   // (1) triggers release callback
      bitmap_free(idxd->opcap_bmap);    // (2) USE AFTER FREE
      ida_free(&idxd_ida, idxd->id);    // (3) DOUBLE ida_free
      kfree(idxd);                      // (4) DOUBLE kfree
  }

Since device_initialize() was called in idxd_alloc(), conf_dev has
refcount=1. Step (1) drops it to 0 and synchronously triggers:

  put_device() -> kobject_put() -> kobject_release() -> kobject_cleanup()
    -> device_release() -> dev->type->release -> idxd_conf_device_release()

idxd_conf_device_release() (in sysfs.c) already does:

  static void idxd_conf_device_release(struct device *dev)
  {
      struct idxd_device *idxd = confdev_to_idxd(dev);
      kfree(idxd->groups);
      bitmap_free(idxd->wq_enable_map);
      kfree(idxd->wqs);
      kfree(idxd->engines);
      kfree(idxd->evl);
      kmem_cache_destroy(idxd->evl_cache);
      ida_free(&idxd_ida, idxd->id);    // <- FIRST ida_free
      bitmap_free(idxd->opcap_bmap);    // <- FIRST bitmap_free
      kfree(idxd);                      // <- FIRST kfree
  }

So after put_device() returns in idxd_free():
  - idxd pointer is dangling (memory freed)
  - idxd->opcap_bmap is dangling
  - idxd->id has already been freed from the IDA

Steps 2-4 then operate on freed memory, corrupting the slab allocator.

The same pattern exists in idxd_alloc() at the err_name label.

How to Reproduce
----------------

This occurs during kdump (crash dump collection) on systems with
Intel IDXD hardware:

  1. System has Intel IDXD (DSA/IAX) -- e.g., Granite Rapids / Sapphire
     Rapids platforms
  2. Original kernel panics (any reason)
  3. Kdump kernel boots with: reset_devices nr_cpus=1
  4. IDXD device is in HALTED state due to reset_devices
  5. IDXD driver probes the device -> probe fails -> idxd_free() ->
     double-free -> slab corruption
  6. systemd-udevd loads next module -> module signature verification
     allocates memory -> hits corrupted slab -> kernel oops

Console Output (kdump kernel)
-----------------------------

  [   18.628791] idxd 0000:00:01.0: Device is HALTED!
  [   18.631447] idxd 0000:00:01.0: Intel(R) IDXD DMA Engine init failed
  [   18.631450] ------------[ cut here ]------------
  [   18.631451] ida_free called for id=0 which is not allocated.
  [   18.631462] WARNING: CPU: 0 PID: 11 at lib/idr.c:525 ida_free+0xd3/0x130
  [   18.631502]  idxd_pci_probe+0x1b0/0x1860 [idxd]
    ...
  [   18.898798] BUG: unable to handle page fault for address: ff2c9dd300000010
  [   18.931865] RIP: 0010:___slab_alloc+0x168/0xa10
    ...
  [   19.097220]  __kmalloc_cache_noprof+0x82/0x230
  [   19.102683]  mpi_alloc+0x20/0x80
  [   19.106676]  rsa_enc+0x2f/0x120
  [   19.110549]  pkcs1pad_verify+0x13b/0x1a0
    ...
  [   19.161968]  module_sig_check+0x87/0xe0
  [   19.166709]  load_module+0x3c/0x1e80

Affected Versions
-----------------

  - Mainline: present at HEAD (introduced Apr 2025)
  - Stable: v6.12.30+ (backport commit 017d4012dc05)
  - Also present in other stable branches that received the backport

Test Platform
-------------

  - Dell PowerEdge XR8720t
  - Intel Xeon 6716P-B (Granite Rapids)
  - Kernel: 6.12.0-1-rt-amd64 (StarlingX 6.12.40-1.stx.140)
  - RT: PREEMPT_RT

Why This Was Not Caught Earlier
-------------------------------

  1. The error path only triggers when IDXD device is HALTED -- this
     only happens with reset_devices (kdump) or hardware error
  2. On normal boot, IDXD probe always succeeds
  3. Most kdump configurations blacklist IDXD via module_blacklist=
  4. Systems without IDXD hardware are unaffected
  5. The ida_free WARNING alone doesn't crash -- it's the subsequent
     slab corruption that causes the fatal oops, which may appear as
     an unrelated bug

Workaround
----------

Add idxd to module_blacklist in the kdump kernel command line:

  module_blacklist=idxd,idxd_bus

Fix
---

Remove the duplicate bitmap_free/ida_free/kfree from idxd_free()
since idxd_conf_device_release() (triggered by put_device()) already
handles all resource deallocation. Similarly fix idxd_alloc() err_name
path.

Related Commits
---------------

  - 90022b3a6981 ("dmaengine: idxd: fix memory leak in error handling
    path of idxd_pci_probe") -- introduces the bug
  - 46a5cca76c76 ("dmaengine: idxd: fix memory leak in error handling
    path of idxd_alloc") -- same pattern in idxd_alloc
  - f41c538881ee ("dmaengine: idxd: Remove improper idxd_free") -- fixes
    the same function but only in idxd_remove(), not probe error path
  - c311f5e9248471 ("dmaengine: idxd: Fix freeing the allocated ida too
    late") -- establishes the correct pattern for cdev (ida_free before
    put_device, not in .release())

Thanks,
Bogdan

Bogdan Codres (1):
  dmaengine: idxd: fix use-after-free in idxd_free() and idxd_alloc()
    error paths

 drivers/dma/idxd/init.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

-- 
2.43.0

