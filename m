Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7244A3BE5
	for <lists+dmaengine@lfdr.de>; Mon, 31 Jan 2022 00:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243835AbiA3XmL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 30 Jan 2022 18:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiA3XkR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 30 Jan 2022 18:40:17 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6822EC06173D
        for <dmaengine@vger.kernel.org>; Sun, 30 Jan 2022 15:40:17 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id jx6so37407201ejb.0
        for <dmaengine@vger.kernel.org>; Sun, 30 Jan 2022 15:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:content-language
         :from:subject:to:content-transfer-encoding;
        bh=pjT36NDPPbNcthiKvEeSn2Sjhkn/jTmjKx0MlFo8Ku8=;
        b=C7ig9ckfZBpSBAyFOc5zd1NKDEJTNdvdphq+sYy3qFAsoF2cwuMT+hxaiI8qVLykBw
         +aHe9kb7l8Ji2Dst4IOKz3vFAEWVkOl8/PIw0rorndgf47WTeyvCEEPC93R9jbTtSPWt
         pcKZFlJ96Nr6Qb0RuwFrgpUeKWmPYc59eWJqHjUn5ASm269HQpdsH65Eag/Jghr2Q8Jk
         YXOm8xxR3kE1WNdV+Cpnww+ftCxflG2AkLV5VEvRLFoS5IVE6HFiURZndLFmiGxX1Tny
         sfMtxL8y+y91TmsifQH8D9rg74hP4XaZSOPCwYbupRHgmOr/rpal5/UaO/XWUemdY1Ot
         xa2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :content-language:from:subject:to:content-transfer-encoding;
        bh=pjT36NDPPbNcthiKvEeSn2Sjhkn/jTmjKx0MlFo8Ku8=;
        b=ctgKOntctg6O6XDCRizwhn3eXucQaB9uRzWAejILBJg59LQsMvTwrDfA+OdPtpN5ZX
         7gMPYK3AsyDjqZJzLplydTGTSGeHxWi0wdaA2uzIko6YiivkAXcdLoran9WlLfjFoWDt
         d7R2aA38+xN1Ss0c/2xV6hIy/MGacjuMpMjSW0Gl1t+fJ5aeCYHC3EzqkiVahd1/nDS+
         1Z1bPjcTrFGkDzcLaBrwtXZ6X2BDneEtkSucULAiOVSivci4saKOVYbeVJRG9qhD2pk9
         VcLzBx+gpOyz/qrmW9dXqsyPiGTzZ0QuyeOQ+CKcZsIXz6tFjxiaMZqlC3vDQNpdygJT
         oSDw==
X-Gm-Message-State: AOAM532UsALXgdiqVarts1sh5bcQEX6d7pBdOnVeunNFuXhBchCRXGzW
        n6jPQr/W21JFNApXtm9yKCA=
X-Google-Smtp-Source: ABdhPJwp10QYU7dPq9te1kB2YTcukTT/GI2UDNWkbchTNNdDE4+jHUyx4IUVmSMlLjUDiCJwjwaONQ==
X-Received: by 2002:a17:907:62a0:: with SMTP id nd32mr15213870ejc.96.1643586016018;
        Sun, 30 Jan 2022 15:40:16 -0800 (PST)
Received: from [192.168.43.21] ([197.234.221.208])
        by smtp.gmail.com with ESMTPSA id s26sm16935059eds.39.2022.01.30.15.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jan 2022 15:40:15 -0800 (PST)
Message-ID: <4a3032ee-93e3-17c1-4957-4366f6234ed9@gmail.com>
Date:   Mon, 31 Jan 2022 00:40:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.2; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Reply-To: dodjinoumonvi7@gmail.com
Content-Language: fr
From:   dom mahoube <dominiquemahougbe@gmail.com>
Subject: donation
To:     destinataires inconnus:;
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Gracias por responderme, me hizo muy feliz. Efectivamente se trata de una donación de .2000.000 €. Y lo hago porque mi padre espiritual me aconsejó tener más esperanza ya sé mi fecha de caducidad (fin de mi existencia en esta tierra) claro que soy creyente cristiano pero la ciencia está más avanzada.
  Ahora quiero que me hables de ti en unas pocas líneas: hago esta donación porque mi padre espiritual me aconsejó, soy un cristiano sin hijos entonces ¿por qué morir con todo lo que tengo?
Es por eso que comencé a buscar a la persona adecuada que pudiera administrar bien mis activos incluso después de mi muerte.
Así que dime una vez si recibes este regalo, ¿qué vas a hacer primero? ¿Te gustan los niños? ¿Qué significa el próximo amor para ti? Por favor respóndame para que pueda ponerlo en contacto con mi notario para establecer los documentos que le permitan cuidar al heredero legal de mi propiedad.



Gracias por entender y esperar a leer de usted.



WhatsApp:..... +33 780 957 132



Atentamente.

Thank you for answering me, it made me very happy. It is indeed a donation of 2.000.000 €. And I do it because my spiritual father advised me to have more hope I already know my expiry date (end of my existence on this earth) of course I am a Christian believer but science is more advanced .
  Now I want you to tell me about yourself in a few lines: I make this donation because my spiritual father advised me, I am a childless Christian so why then die with everything I have?
That's why I started looking for the right person who could manage my assets well even after my death.
So tell me once if you receive this gift, what are you going to do first? Do you like children? What does next love mean to you? Please answer me so that I can put you in contact with my notary to establish the documents to allow you to take care of the legal heir of my property.



Thank you for understanding and waiting to read from you.



WhatsApp:..... +33 780 957 132



Cordially.

