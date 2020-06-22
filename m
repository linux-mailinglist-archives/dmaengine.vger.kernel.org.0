Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720BB203BAD
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2020 17:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgFVP6g (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Jun 2020 11:58:36 -0400
Received: from sonic302-21.consmr.mail.ne1.yahoo.com ([66.163.186.147]:44705
        "EHLO sonic302-21.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729250AbgFVP6g (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Jun 2020 11:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1592841515; bh=ac0sCjJUI93cXt8Ne4UV+BUmdTO8c8UeaDLEdPti3zY=; h=Date:From:Reply-To:Subject:References:From:Subject; b=scCB+Q6Gjf0KzflGkUiiHnirxZPhUadIbQy4yqWUwgd55dcbqJHRgQGLKmTmzqJRp9B2jypnIKM0+UPee5Qdin17acYTeNSrZNUWc6b8oFHl1JV6YKexGdFVS+/g68rZoDDx9kHpElPAxiEVNlQC8DiI6l9b0bVmEziivC8tnStES7wQyJe+E5PdVac/SOi9fBmvp+eAJtQBd8y/Fgr2PCNau4wnbAY64iunL4XaQjLCqJ139Y7RY8FW2N+MyDAiVOai0ceUcO2kUiFo4FiBwCBNMJq9ytN3HTe7p8faMG9+6vDMjF/bPQnwGRC3YsYHGGXB+LMYsdqWdmJRLW/Axw==
X-YMail-OSG: Dx4DwhEVM1nMKsfl753AL1pa_1MAl8PfB8S1hTI6fa0HXgcVGSu063xlTclFjGM
 Tws5nt5YK7rscRG_1mkppPcX.Erbobn8VyUscr9DzjmOdR1UzLYgvXUvwhaZ7ryd1WNLUxbzGTWZ
 KbS4DctdPNI3mv1hwwM_UZnyBQvKFBybprZU35c3IxT4Lyw41JmhXjAi784Nn2ypycxtE8eKgoW1
 L41NbW6aZHZvtjCd5OZ1YuuIsrybZOWnlx2YD9JufWql.U0.H4v8oIuuL5ePMzn8ubBi49QDnv.k
 YWliC2QYR8SeTaHA1giR.cczaM4SDsn.6AG2OqP38l4y.ANQ3RhADP6n3fsDMIgVAqwC4lQFXuH4
 8mslR4RB8TxntYo8eTAVJj_yMmLP7hEkTBa.ovdicFbV00z4EfmVLkHPi971cPA59HIf1fTiu5EY
 hkoJhl2Ss1sDmzehldZhUO_zbjfWoO0J_ar5mrHAdQrZl8XBanSCqVUAUj13U88AjW3UthilWyZB
 gdhHlDgfsV6hdx51ZsdEgrNGnND41QNriAPwC2X4LADhjlssDD0ll2zrYI8xS0_uRi3rgaNXa_qx
 .qhLlOqvP5BlTMHWYE_A6aka2RWQ9Ge6dfqtZfecpiBoI684jYmkMa4s7SIJ6Xie.RCfp4s82uJa
 a7ah.2fuCxJnxTVL8g9.uCLWZjhj_l7sZzzc99TTa0_U5r5Iu_MIK7midAJA27doj1Mh3gECuy_u
 EUwWWBkn6PsZMHiFM9DtKhLHunaHNxtIJYqynw6_V8nJOMKaFJc6lUxXPbGZzolNX3R5My4wimNw
 3zCYTc1boqkUzSaUoKws_OgOHDPCd7p_T0pME_PS.gkwTdScv.ZvvUviqwp4ZXwW8Gv8HvdzK_3T
 RgctJIfLBUlvQd94oTCmBfbQjgtMK8iDI2fG0tGIqt54fchCYNZWvsjm2p1_zsqIoCzVCuIhQRxP
 IPUIc45AD_PHDPYsVAf2WbjRu2z4bM_yPsp3z28AcqdCSGZZg0bCPVWWyRdwnyymN9GJFlBarMeC
 bimltNJ2B5bQG36hI9AyJDXtfqoK89rSiGL_HdR.kfXEb88dpSQ3tA8rrw5mnWKH6l_UR8kZcYav
 N1lVsOwcwlkyi4sjcUs9P4AYeu.TBh1WZuj89heu5qvwpFQSOsjpoKN5u.y0QEpabN9EnLs_kiaL
 OUVmoS1GwABBJSEmGcKs0iRrnpw55fDV1OvEmMwWjEz6pkcOoxSaAtsUPwlpKW9KohCdEOZqTedT
 3mLuj4Wab9.aQVB8jP_uJLcIpaZbaGBDIKk9ZuTtW8zpp9lm8y5PcigeF3iSLLUJXXixKbJDhRw-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Mon, 22 Jun 2020 15:58:35 +0000
Date:   Mon, 22 Jun 2020 15:58:31 +0000 (UTC)
From:   Karim Zakari <kariim1960z@gmail.com>
Reply-To: kzakari04@gmail.com
Message-ID: <823920628.1857692.1592841511779@mail.yahoo.com>
Subject: URGENT REPLY.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <823920628.1857692.1592841511779.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16138 YMailNodin Mozilla/5.0 (Windows NT 6.1; ) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



Good-Day=C2=A0Friend,

=C2=A0Hope=C2=A0you=C2=A0are=C2=A0doing=C2=A0great=C2=A0Today.=C2=A0I=C2=A0=
have=C2=A0a=C2=A0proposed=C2=A0business=C2=A0deal=C2=A0worthy=C2=A0(US$16.5=
=C2=A0Million=C2=A0Dollars)=C2=A0that=C2=A0will=C2=A0benefit=C2=A0both=C2=
=A0parties.=C2=A0This=C2=A0is=C2=A0legitimate'=C2=A0legal=C2=A0and=C2=A0you=
r=C2=A0personality=C2=A0will=C2=A0not=C2=A0be=C2=A0compromised.

Waiting=C2=A0for=C2=A0your=C2=A0response=C2=A0for=C2=A0more=C2=A0details,=
=C2=A0As=C2=A0you=C2=A0are=C2=A0willing=C2=A0to=C2=A0execute=C2=A0this=C2=
=A0business=C2=A0opportunity=C2=A0with=C2=A0me.

Sincerely=C2=A0Yours,
Mr.=C2=A0Karim=C2=A0Zakari.
